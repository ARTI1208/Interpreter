grammar Ninja;

options {
	language=CSharp ;
}

@parser::members 
{
	public enum ParamType
	{
		Receive, Pass
	};

	public enum CallType
	{
		BuiltIn, Custom
	};
	
	public enum VarType
    {
    	Int, Double, Bool
    };
    
    public enum ReturnType
    {
    	Int, Double, Bool, Void
    };

	public class ParamData
	{
		
        public string name;
        
        public dynamic value;
	
		public VarType type;	
		
		public ParamType paramType = ParamType.Receive;	
	
		public override string ToString()
        {
            return $"param {type} {name}";
        }
	}
	
	public class VarData
    {
        public string name;
        public VarType type;
        public dynamic value;
        
    }

    public class MethodData : Block
    {public string name;
		public bool isMeaningful;
        public ReturnType returnType = ReturnType.Void;
        public ArrayList<NinjaParser.ParamData> paramList = new ArrayList<NinjaParser.ParamData>();
        
		public dynamic returnValue;
		
		public override void Eval()
        {
        	parser.curBlock = this;
        	Debug($"===Entering fun {name} with params {ParamListToString(paramList)}");
            foreach(var sm in operations)
            {
            	if(sm.GetType().IsSubclassOf(typeof(OperationClass)))
            		sm.Eval();
            }
            
            Debug($"---Vars of block met {name} ----");	
            foreach (var elem in varTable)
            {
                Console.WriteLine("\t" + elem.Key + " is " + elem.Value.type + " with value " + elem.Value.value);
            }
            Debug($"---End Vars of block met {name} ----");
            Debug($"===Exiting fun {name}");	
        	
        }
        
        public override string ToString()
        {
        	return $"fun {returnType} {name}, params : {paramList} ";
        }
    }
 
    public Dictionary<string, MethodData> metTable = new Dictionary<string, MethodData>();
    int depth = 0;
    string currentMet = "?";
    
    public static void Debug(string line)
    {
        Console.WriteLine(line);
    }
    
    public static void Error(string message)
    {
        ConsoleColor curr = Console.ForegroundColor;
        Console.ForegroundColor = ConsoleColor.Red;
        Console.WriteLine(message);
        Console.ForegroundColor = curr;
    }
    
    public static bool CheckType(Type t, VarType vt)
    {
    	if(t.ToString().ToLower().Contains("bool") && vt.ToString().ToLower().Contains("bool"))
    		return true;
    	if(t.ToString().ToLower().Contains("int") && vt.ToString().ToLower().Contains("int"))
            return true;
        if(t.ToString().ToLower().Contains("double") && vt.ToString().ToLower().Contains("double"))
            return true;
        return false;        	
    }
    
    public static bool CheckType(Type t, ReturnType vt)
        {
        	if(t.ToString().ToLower().Contains("bool") && vt.ToString().ToLower().Contains("bool"))
        		return true;
        	if(t.ToString().ToLower().Contains("int") && vt.ToString().ToLower().Contains("int"))
                return true;
            if(t.ToString().ToLower().Contains("double") && vt.ToString().ToLower().Contains("double"))
                return true;
            return false;        	
        }
	
	public bool CheckParams(NinjaParser.CallData call, NinjaParser.MethodData method)
    {
    	Console.WriteLine($"Checking params of {call.name}");
    	if (call.paramList.Count != method.paramList.Count)
    	{
    		Console.WriteLine($"Expected params {method.paramList.Count}, found {call.paramList.Count}");
    		return false;
    	}
    
    	for (int i = 0; i < call.paramList.Count; i++)
    	{
    		var r = call.paramList[call.paramList.Count - i - 1].value;//.Eval();		
    		//if (call.paramList[i].type == method.paramList[i].type)
    		if (r is string varId)
    			if(curBlock.varTable.ContainsKey(varId))
    				r = FindVar(varId).value;
    			else
    			{
    				Console.WriteLine($"Type mismatch ({i+1}/{call.paramList.Count}): expected {method.paramList[i].type}, found {r.GetType()} with value {call.paramList[call.paramList.Count - i - 1].value}");
                    return false;
    			}
    				
    		if (CheckType(r.GetType(), method.paramList[i].type))
    		{
    			method.paramList[i].value = r;
				if (!method.varTable.ContainsKey(method.paramList[i].name))
               	{
                	VarData varData = new VarData()
                	{
                		name = method.paramList[i].name,
						type = method.paramList[i].type
               		};
               		method.varTable.Add(varData.name, varData);
               	}
                	                
    			method.varTable[method.paramList[i].name].value = r;
    			Console.WriteLine($"Param \"{method.paramList[i].name}\" of type {method.paramList[i].type} with val {call.paramList[i].value}");
    		}
    		else
    		{
    			Console.WriteLine($"Type mismatch ({i+1}/{call.paramList.Count}): expected {method.paramList[i].type}, found {r.GetType()} with value {call.paramList[call.paramList.Count - i - 1].value}");
    			return false;
    		}
    	}
    
    	return true;
    }
            		
	ArrayList<byte> _bytes = new ArrayList<byte>();
	
	static string ParamListToString(ArrayList<NinjaParser.ParamData> list)
    {
    	string s = "{";
    	foreach (var data in list)
    	{
    	
    		if(data.value.GetType() == typeof(ExprClass))
    			s += $" {data.type} {data.value.Eval()},";
    		else
    		{
    	
    			if (data.paramType == NinjaParser.ParamType.Pass)
    			{
	    			s += $" {data.type} {data.value},";	
    			}
	    		else
    			{
    				s += $" {data.type} {data.name} = {data.value},";	
    			}
    		
    		}
    	}
    
    	s = (s.Length > 1 ? s.Substring(0, s.Length - 1) : s) + " }";
    	return s;
    }
	
	public class Block
	{
		public NinjaParser parser;
		
		public List<OperationClass> operations = new List<OperationClass>();
		public Dictionary<string, VarData> varTable = new Dictionary<string, VarData>();
		
		public Block Parent;
		
		public virtual void Eval()
		{
			for (int i = 0; i < operations.Count; ++i)
				operations[i].Eval();
		}
		
		public OperationClass createOperationClass()
		{
			operations.Add(new OperationClass());
			return operations[operations.Count - 1];
		}
		
		public ExprClass ToExpr()
		{
			int lastInd = operations.Count - 1;
			var res = new ExprClass(operations[lastInd]);
			res.parser = parser;
			operations[lastInd] = res;
			return res;
		}
	}
	
	public class CallData : OperationClass
	{
		public string name;
			
		public dynamic value;
			
		public CallType callType;
		
		public ReturnType returnType;
		
		public Block parent;
			
		public ArrayList<NinjaParser.ParamData> paramList = new ArrayList<NinjaParser.ParamData>();
		
		public override dynamic Eval()
		{
			if (callType == NinjaParser.CallType.Custom)
			{
				if (parser.metTable.ContainsKey(name) && parser.CheckParams(this, parser.metTable[name]))
				{
					
					parser.metTable[name].Eval();
					var ret = parser.metTable[name].returnValue.Eval();
					
					
                    	if (!CheckType(ret.GetType(), parser.metTable[name].returnType)){
                    		throw new Exception($"Actual return is {ret.GetType()}, expected declared return type {parser.metTable[name].returnType}");
                    	}
					
					parser.curBlock = parent;
					return ret;
					
				}
			}
			else
			{
				if (parser.metTable.ContainsKey(name))
				{
					if(parser.CheckParams(this, parser.metTable[name]))
					{
						Console.WriteLine($"Calling builtin method {name} with params {ParamListToString(paramList)}, ret {parser.metTable[name].returnValue}");
						return parser.metTable[name].returnValue;
					}	
				} 
				else
				{			
					Console.WriteLine($"Calling builtin method {name} with params {ParamListToString(paramList)}");
					switch (name)
					{
						case "move":
							parser._bytes.Add(1);
							break;
						case "turn":
							parser._bytes.Add(2);
							break;
						case "hit":
							parser._bytes.Add(3);
							break;
						case "shoot":
							parser._bytes.Add(4);
							break;
						default:
							Error($"Unknown builtin method {name}");
							break;
					}
				}
			}
			return null;
		}
	}
	
	public Block curBlock = new Block();
	
	public class OperationClass
	{
		public NinjaParser parser;
		
		public OperationClass()
		{
			
		}
		
		public OperationClass(OperationClass op)
		{
			
		}
		
		public virtual dynamic Eval()
		{
			throw new NotImplementedException("OperationClass class is abstract");
		}
	}
    
	public enum ObjType
	{
		Number, Logic, Var, Operation, Function
	}

	public class ExprStackObject
	{
		public NinjaParser parser;
		public ObjType type;
		public dynamic value;
		
		public ExprStackObject(): this(0, null) { }
		
		public ExprStackObject(double value, NinjaParser parser)
		{
			type = ObjType.Number;
			this.value = value;
			this.parser = parser;
		}

		public ExprStackObject(int value, NinjaParser parser)
		{
			type = ObjType.Number;
			this.value = value;
			this.parser = parser;
		}
		
		public ExprStackObject(bool value, NinjaParser parser)
		{
			type = ObjType.Number;
			this.value = value;
			this.parser = parser;
		}
		
		public dynamic Calc()
		{
					Debug($"Calculatinf {type}, {value}");
            				if (type == ObjType.Number)
            					return value;
            				if (type == ObjType.Var)
            				{
            					Block par = parser.curBlock;
								while (!par.varTable.ContainsKey(value))
								{
									par = par.Parent;
									if (par == null)
									{
										break;
									}
								}
                                
								if (par == null)
								{
									Console.WriteLine($"Unknown var {value}!!!");
									Debug($"nkeys {parser.curBlock.varTable.Keys.Count}");
									foreach (var key in parser.curBlock.varTable.Keys)
									{
										Debug($"nkey {key}");
									}
									
									foreach (var key in parser.curBlock.Parent.varTable.Keys)
                                    									{
                                    										Debug($"nkey2 {key}");
                                    									}
								}
								Debug(value + par.varTable[value].value);
            					return par.varTable[value].value;
            				}
            
            				Error("\"" + value + "\" is an operation");
            				return null;
		}
		
		public new Type GetType()
		{
			VarType type = parser.FindVar(value).type;
        	switch (type)
        	{
        		case VarType.Int:
	        		return typeof(int);	
        		case VarType.Double:
        			return typeof(double);		
        		case VarType.Bool:
        			return typeof(bool);
			}
			Error("Variable " + value + " has an unknown type");
        	return null;
        }
	}
	
	public class ExprClass : OperationClass
	{
		public List<ExprStackObject> exprStack;
		
		public ExprClass(OperationClass parent) : base(parent)
		{
			exprStack = new List<ExprStackObject>();
			//parser.curBlock.operations.Add(this);
		}
		
		public void Push(ExprStackObject value)
		{
			exprStack.Add(value);
		}
		
		public ExprStackObject Pop(List<ExprStackObject> vals)
		{
			var res = vals[vals.Count - 1];
			vals.RemoveAt(vals.Count - 1);
			return res;
		}
		
		public bool isCompatible(dynamic value1, dynamic value2, bool isLeftVar = false)
		{
			if (value1.GetType() == value1.GetType())
				return true;
			else if (value1.GetType() == typeof(double) && value2.GetType() == typeof(int))
				return true;
			else if (!isLeftVar && value1.GetType == typeof(int) && value2.GetType() == typeof(double))
				return true;
			return false;
		}		
		
		public ReturnType expectedReturnType;
		public dynamic value;
		
		public override dynamic Eval()
		{
			string s = "";
			foreach(var v in exprStack)
			{
				s += v.value;
			}
			Debug($"Evaluating {s}");
			List<ExprStackObject> stack = new List<ExprStackObject>();
			foreach (var elem in exprStack)
			{
				if (elem.type == ObjType.Number || elem.type == ObjType.Var)
					stack.Add(elem);
				else if (elem.type == ObjType.Function)
				{
					Debug($"evals {elem.value.name}");
					ArrayList<ParamData> pars = elem.value.paramList;
					for (int i = 0; i < pars.Count; ++i)
					{
						dynamic val = Pop(stack);
						val.Calc();
						pars[i].value = val.value;
					}
					dynamic result;
					if (elem.value == null)
					{
						result = -1;
					}
					else
					{
						if (elem.value.GetType() == typeof(int))
							result = elem.value;
						else if (elem.value.GetType() == typeof(double))
							result = elem.value;
						else if (elem.value.GetType() == typeof(bool))
							result = elem.value;
						else
							result = elem.value.Eval();
					}
					stack.Add(new ExprStackObject(result, parser));
				}
				else
				{
					ExprStackObject left, right;
					dynamic leftVal, rightVal;
                    					switch (elem.value)
                    					{
                    						case "&&":
                    							right = Pop(stack);
                    							left = Pop(stack);
                    							leftVal = left.Calc();
                    							rightVal = right.Calc();
                    							if (!isCompatible(leftVal, rightVal))
                    								Error("Incompatible types of values " + leftVal + " and " + rightVal);
                    							stack.Add(new ExprStackObject(leftVal && rightVal, parser));
                    							break;
                    						
                    						case "||":
                    							right = Pop(stack);
                    							left = Pop(stack);
                    							leftVal = left.Calc();
                    							rightVal = right.Calc();
                    							if (!isCompatible(leftVal, rightVal))
                    								Error("Incompatible types of values " + leftVal + " and " + rightVal);
                    							stack.Add(new ExprStackObject(leftVal || rightVal, parser));
                    							break;
                    						
                    						case "!":
                    							right = Pop(stack);
                    							rightVal = right.Calc();
                    							if (rightVal.GetType() != typeof(bool))
                    								Error("Bool is required instead of " + rightVal);
                    							stack.Add(new ExprStackObject(!rightVal, parser));
                    							break;
                    							
                    						case "<":
                    							right = Pop(stack);
                    							left = Pop(stack);
                    							leftVal = left.Calc();
                    							rightVal = right.Calc();
                    							if (!isCompatible(leftVal, rightVal))
                    								Error("Incompatible types of values " + leftVal + " and " + rightVal);
                    							stack.Add(new ExprStackObject(leftVal < rightVal, parser));
                    							break;
                    						
                    						case ">":
                    							right = Pop(stack);
                    							left = Pop(stack);
                    							leftVal = left.Calc();
                    							rightVal = right.Calc();
                    							if (!isCompatible(leftVal, rightVal))
                    								Error("Incompatible types of values " + leftVal + " and " + rightVal);
                    							stack.Add(new ExprStackObject(leftVal > rightVal, parser));
                    							break;
                    						
                    						case "==":
                    							right = Pop(stack);
                    							left = Pop(stack);
                    							leftVal = left.Calc();
                    							rightVal = right.Calc();
                    							if (!isCompatible(leftVal, rightVal))
                    								Error("Incompatible types of values " + leftVal + " and " + rightVal);
                    							stack.Add(new ExprStackObject(leftVal == rightVal, parser));
                    							break;
                    						
                    						case "!=":
                    							right = Pop(stack);
                    							left = Pop(stack);
                    							leftVal = left.Calc();
                    							rightVal = right.Calc();
                    							if (!isCompatible(leftVal, rightVal))
                    								Error("Incompatible types of values " + leftVal + " and " + rightVal);
                    							stack.Add(new ExprStackObject(leftVal != rightVal, parser));
                    							break;
                    						
                    						case "<=":
                    							right = Pop(stack);
                    							left = Pop(stack);
                    							leftVal = left.Calc();
                    							rightVal = right.Calc();
                    							if (!isCompatible(leftVal, rightVal))
                    								Error("Incompatible types of values " + leftVal + " and " + rightVal);
                    							stack.Add(new ExprStackObject(leftVal <= rightVal, parser));
                    							break;
                    						
                    						case ">=":
                    							right = Pop(stack);
                    							left = Pop(stack);
                    							leftVal = left.Calc();
                    							rightVal = right.Calc();
                    							if (!isCompatible(leftVal, rightVal))
                    								Error("Incompatible types of values " + leftVal + " and " + rightVal);
                    							stack.Add(new ExprStackObject(leftVal >= rightVal, parser));
                    							break;
                    					
                    						case "+":
                    							right = Pop(stack);
                    							left = Pop(stack);
                    							leftVal = left.Calc();
                    							rightVal = right.Calc();
                    							if (!isCompatible(leftVal, rightVal))
                    								Error("Incompatible types of values " + leftVal + " and " + rightVal);
                    							stack.Add(new ExprStackObject(leftVal + rightVal, parser));
                    							break;
                    						
                    						case "-":
                    							right = Pop(stack);
                    							left = Pop(stack);
                    							leftVal = left.Calc();
                    							rightVal = right.Calc();
                    							if (!isCompatible(leftVal, rightVal))
                    								Error("Incompatible types of values " + leftVal + " and " + rightVal);
                    							stack.Add(new ExprStackObject(leftVal - rightVal, parser));
                    							break;
                    						
                    						case "*":
                    							right = Pop(stack);
                    							left = Pop(stack);
                    							leftVal = left.Calc();
                    							rightVal = right.Calc();
                    							if (!isCompatible(leftVal, rightVal))
                    								Error("Incompatible types of values " + leftVal + " and " + rightVal);
                    							stack.Add(new ExprStackObject(leftVal * rightVal, parser));
                    							break;
                    						
                    						case "/":
                    							right = Pop(stack);
                    							left = Pop(stack);
                    							leftVal = left.Calc();
                    							rightVal = right.Calc();
                    							if (!isCompatible(leftVal, rightVal))
                    								Error("Incompatible types of values " + leftVal + " and " + rightVal);
                    							stack.Add(new ExprStackObject(leftVal / rightVal, parser));
                    							break;
                    						
                    						case "++pre":
                    							right = Pop(stack);
                    							rightVal = right.Calc();
                    							if (!isCompatible(0, rightVal))
                    								Error(rightVal + " can't be incremented");
                    							++parser.FindVar(right.value).value;
                    							stack.Add(new ExprStackObject(rightVal, parser));
                    							break;
                    							
                    						case "++post":
                    							right = Pop(stack);
                    							rightVal = right.Calc();
                    							if (!isCompatible(0, rightVal))
                    								Error(rightVal + " can't be incremented");
                    							stack.Add(new ExprStackObject(rightVal, parser));
                    							++parser.FindVar(right.value).value;
                    							break;
                    							
                    						case "--pre":
                    							right = Pop(stack);
                    							rightVal = right.Calc();
                    							if (!isCompatible(0, rightVal))
                    								Error(rightVal + " can't be decremented");
                    							--parser.FindVar(right.value).value;
                    							stack.Add(new ExprStackObject(rightVal, parser));
                    							break;
                    							
                    						case "--post":
                    							right = Pop(stack);
                    							rightVal = right.Calc();
                    							if (!isCompatible(0, rightVal))
                    								Error(rightVal + " can't be decremented");
                    							stack.Add(new ExprStackObject(rightVal, parser));
                    							--parser.FindVar(right.value).value;
                    							break;
                    							
                    						case "=":
                    							right = Pop(stack);
                    							left = Pop(stack);
                    							try
                    							{
                    								foreach(var key in parser.curBlock.varTable.Keys)
                    								{
                    									Debug($"|||{key}||| with type {parser.curBlock.varTable[key].value.GetType()}");
                    									if (key == "op")
                    									{
                    										Debug(parser.curBlock.varTable["op"].value + "nono");
                    									}
                    								}
                    								rightVal = right.Calc();
                    								if (!isCompatible(left, rightVal, true))
                    									Error("Can't assign " + rightVal + " to " + left.value);
                    								dynamic rightval = rightVal;
                    								string su = (string) left.value;
                    								VarData data = parser.FindVar(su);
                    								Debug("ishere?");
                    								if (data.value.GetType() == rightval.GetType())
                    									data.value = rightval;
                    								else if (data.type == VarType.Double)
                    									data.value = (double)rightval;
                    								else
                    									Error("Can't convert \"" + rightval + "\" to " + data.type);
                    								Debug("oshere?");
                    								Debug($"var \"{left.value}\" of type {parser.FindVar(left.value).type} = {data.value}");	
                    								stack.Add(new ExprStackObject(data.value, parser));
                    							}
                    							catch (KeyNotFoundException e)
                    							{
                    								Debug("what exist");
                    								foreach(var key in parser.curBlock.varTable.Keys)
                    								{
                    									Debug($"|||{key}||| with type {parser.curBlock.varTable[key].value.GetType()}");
                    									if (key == "op")
                    									{
                    										Debug(parser.curBlock.varTable["op"].value + "ioio");
                    									}
                    								}
                                                								
                    								Error("Variable " + left.value + " does not exist in current context1\n" + e.StackTrace);
                    							}
                    							break;
                    						
                    						case "+=":
                    							right = Pop(stack);
                    							left = Pop(stack);
                    							try
                    							{
                    								rightVal = right.Calc();
                    								if (!isCompatible(left, rightVal, true))
                    									Error("Can't assign " + rightVal + " to " + left.value);
                    								dynamic rightval = rightVal;
                    								VarData data = parser.FindVar(left.value);
                    								if (data.value.GetType() == rightval.GetType())
                    									data.value += rightval;
                    								else if (data.type == VarType.Double)
                    									data.value += (double)rightval;
                    								else
                    									Error("Can't convert \"" + rightval + "\" to " + data.type);
                    								stack.Add(new ExprStackObject(data.value, parser));
                    							}
                    							catch (KeyNotFoundException)
                    							{
                    								Error("Variable " + left.value + " does not exist in current context2");
                    							}
                    							break;
                    						
                    						case "-=":
                    							right = Pop(stack);
                    							left = Pop(stack);
                    							try
                    							{
                    								rightVal = right.Calc();
                    								if (!isCompatible(left, rightVal, true))
                    									Error("Can't assign " + rightVal + " to " + left.value);
                    								dynamic rightval = rightVal;
                    								VarData data = parser.FindVar(left.value);
                    								if (data.value.GetType() == rightval.GetType())
                    									data.value -= rightval;
                    								else if (data.type == VarType.Double)
                    									data.value -= (double)rightval;
                    								else
                    									Error("Can't convert \"" + rightval + "\" to " + data.type);
                    								stack.Add(new ExprStackObject(data.value, parser));
                    							}
                    							catch (KeyNotFoundException)
                    							{
                    								Error("Variable " + left.value + " does not exist in current context3");
                    							}
                    							break;
                    						
                    						case "*=":
                    							right = Pop(stack);
                    							left = Pop(stack);
                    							try
                    							{
                    								rightVal = right.Calc();
                    								if (!isCompatible(left, rightVal, true))
                    									Error("Can't assign " + rightVal + " to " + left.value);
                    								dynamic rightval = rightVal;
                    								VarData data = parser.FindVar(left.value);
                    								if (data.value.GetType() == rightval.GetType())
                    									data.value *= rightval;
                    								else if (data.type == VarType.Double)
                    									data.value *= (double)rightval;
                    								else
                    									Error("Can't convert \"" + rightval + "\" to " + data.type);
                    								stack.Add(new ExprStackObject(data.value, parser));
                    							}
                    							catch (KeyNotFoundException)
                    							{
                    								Error("Variable " + left.value + " does not exist in current context4");
                    							}
                    							break;
                    						
                    						case "/=":
                    							right = Pop(stack);
                    							left = Pop(stack);
                    							try
                    							{
                    								rightVal = right.Calc();
                    								if (!isCompatible(left, rightVal, true))
                    									Error("Can't assign " + rightVal + " to " + left.value);
                    								dynamic rightval = rightVal;
                    								VarData data = parser.FindVar(left.value);
                    								if (data.value.GetType() == rightval.GetType())
                    									data.value /= rightval;
                    								else if (data.type == VarType.Double)
                    									data.value /= (double)rightval;
                    								else
                    									Error("Can't convert \"" + rightval + "\" to " + data.type);
                    								stack.Add(new ExprStackObject(data.value, parser));
                    							}
                    							catch (KeyNotFoundException)
                    							{
                    								Error("Variable " + left.value + " does not exist in current context5");
                    							}
                    							break;
                    							
                    						case "sin":
                    							right = Pop(stack);
                    							rightVal = right.Calc();
                    							if (!isCompatible(0.0, rightVal))
                    								Error("Can't convert " + rightVal + " to double");
                    							stack.Add(new ExprStackObject(Math.Sin(rightVal), parser));
                    							break;
                    						
                    						case "cos":
                    							right = Pop(stack);
                    							rightVal = right.Calc();
                    							if (!isCompatible(0.0, rightVal))
                    								Error("Can't convert " + rightVal + " to double");
                    							stack.Add(new ExprStackObject(Math.Cos(rightVal), parser));
                    							break;
                    						
                    						case "tan":
                    							right = Pop(stack);
                    							rightVal = right.Calc();
                    							if (!isCompatible(0.0, rightVal))
                    								Error("Can't convert " + rightVal + " to double");
                    							stack.Add(new ExprStackObject(Math.Tan(rightVal), parser));
                    							break;
                    						
                    						case "asin":
                    							right = Pop(stack);
                    							rightVal = right.Calc();
                    							if (!isCompatible(0.0, rightVal))
                    								Error("Can't convert " + rightVal + " to double");
                    							stack.Add(new ExprStackObject(Math.Asin(rightVal), parser));
                    							break;
                    						
                    						case "acos":
                    							right = Pop(stack);
                    							rightVal = right.Calc();
                    							if (!isCompatible(0.0, rightVal))
                    								Error("Can't convert " + rightVal + " to double");
                    							stack.Add(new ExprStackObject(Math.Acos(rightVal), parser));
                    							break;
                    						
                    						case "atan":
                    							right = Pop(stack);
                    							rightVal = right.Calc();
                    							if (!isCompatible(0.0, rightVal))
                    								Error("Can't convert " + rightVal + " to double");
                    							stack.Add(new ExprStackObject(Math.Atan(rightVal), parser));
                    							break;
                    						
                    						case "atan2":
                    							right = Pop(stack);
                    							left = Pop(stack);
                    							rightVal = right.Calc();
                    							leftVal = left.Calc();
                    							if (!isCompatible(0.0, rightVal))
                    								Error("Can't convert " + rightVal + " to double");
                    							if (!isCompatible(0.0, leftVal))
                    								Error("Can't convert " + leftVal + " to double");
                    							stack.Add(new ExprStackObject(Math.Atan2(leftVal, rightVal), parser));
                    							break;
                    					}
					
				}
			}
			if (stack.Count > 0)
            {
            	var res = stack[0];
            	res.Calc();
            	if (res.value is string ss && parser.FindVar(ss) != null)
				{
            		Debug($"Result is {parser.FindVar(ss).value}");
            		value = parser.FindVar(ss).value;
            		return parser.FindVar(ss).value;
            	}
            	Debug($"Result is {res.value}");
            	value = res.value;
            	return res.value;	
            }
            Error("Nothing in stack left");
            return null;
		}
	}
	
	public VarData FindVar(string name)
	{
		Block par = curBlock;
		while (!par.varTable.ContainsKey(name))
		{
			par = par.Parent;
			if (par == null)
			{
				break;
			}
		}                                
		if (par == null)
		{
			Error($"Unknown var {name}!!!");
		}
		return par?.varTable[name];
	} 
	
	public class Cycles: OperationClass
    {
        //public List<OperationClass> callList = new ArrayList<OperationClass>();
        public Block cycleBlock = new Block();
		public ExprClass cond;
		
	}
    
	public class While:Cycles
	{
		public override dynamic Eval()
        {
        	parser.curBlock = cycleBlock;
        	Debug("---Entering whilecycle");
        	int i = 0;
        	while(cond.Eval())
			{
				Debug($"-=-While loop {i++}");
				cycleBlock.Eval();
            }
            Debug("---Exiting whilecycle");
            parser.curBlock = parser.curBlock.Parent;
    		return null;
        }
    }
    
    public class Do_while:Cycles
    {
		public override dynamic Eval()
        {
			do
			{
				cycleBlock.Eval();
			}
			while(cond.Eval());
			return null;
		}
	}
    
    public class For:Cycles
    {
		public ExprClass first;
    	public ExprClass last;
    	
        public override dynamic Eval()
        {
			Debug($"forfirst is {first.Eval()}");
			Debug($"forcond is {cond.Eval()}");
            while(cond.Eval())
            {
            	cycleBlock.Eval();
				Debug($"forlast is {last.Eval()}"); 
            }
    		return null;
        }
    }    
    
    public class Condition:Cycles 
    {
    	public Block elseIfBlock = new Block();
    	//public List<OperationClass> callListElse = new ArrayList<OperationClass>();
        public override dynamic Eval()
        {
        	if(cond.Eval())
            {
            	cycleBlock.Eval();
            }
            else
            {
				elseIfBlock.Eval();
            }
    		return null;
        }
   	}
}

program : function* main function* {
				curBlock.parser = this;
/*if (parser.metTable.ContainsKey("main"))
                	{
                		++depth;
                		//GoThroughCalls(parser.metTable[call.name]);
                		foreach(var sm in parser.metTable["main"].operations)
                		{
                			sm.Eval();
                		}
                	}*/
                MethodData getSelfId = new MethodData(){
                	name = "getSelfId",
                    returnType = ReturnType.Int,
					parser = this
                };	
                MethodData getHealth = new MethodData(){
                    name = "getHealth",
                    returnType = ReturnType.Int,
					parser = this
                };
                ParamData ghp = new ParamData();
                ghp.name = "id";
				ghp.paramType = ParamType.Receive;
				ghp.type = VarType.Int;
				getHealth.paramList.Add(ghp);
                MethodData getPositionX = new MethodData(){
					name = "getPositionX",
					returnType = ReturnType.Double,
					parser = this
				};
				ParamData gpxp = new ParamData();
				gpxp.name = "id";
                gpxp.paramType = ParamType.Receive;
                gpxp.type = VarType.Int;
               	getPositionX.paramList.Add(gpxp);
                MethodData getPositionY = new MethodData(){
                    name = "getPositionY",
					returnType = ReturnType.Double,
					parser = this
				};
				ParamData gpyp = new ParamData();
				gpyp.name = "id";
				gpyp.paramType = ParamType.Receive;
				gpyp.type = VarType.Int;
                getPositionY.paramList.Add(gpyp);
				MethodData getDirection = new MethodData(){
					name = "getDirection",
					returnType = ReturnType.Double,
					parser = this
				};
                ParamData gdp = new ParamData();
                gdp.name = "id";
				gdp.paramType = ParamType.Receive;
				gdp.type = VarType.Int;
				getDirection.paramList.Add(gdp);
				
				
				getSelfId.returnValue = 0;
				getHealth.returnValue = 10;
				getPositionX.returnValue = 0.0;
				getPositionY.returnValue = 0.0;
                getDirection.returnValue = 90.0;
                
                               	
                metTable.Add("getSelfId", getSelfId);
                metTable.Add("getHealth", getHealth);
                metTable.Add("getPositionX", getPositionX);
                metTable.Add("getPositionY", getPositionY);
                metTable.Add("getDirection", getDirection);
				metTable["main"].Eval();
};

main : main_signature OBRACE main_code CBRACE
{
	
};

main_signature : FUN_KEYWORD VOID MAIN LPAREN RPAREN {
	MethodData newMet = new MethodData
	{
		name = "main",
		returnType = ReturnType.Void,
		parser = this
	};
	metTable.Add("main", newMet);
	currentMet = "main";
	curBlock = newMet;
};

function : v_function | m_function ;

v_function: v_fun_signature OBRACE code CBRACE;

v_fun_signature returns [string funName]: FUN_KEYWORD VOID ID 
{
	string methodName = $ID.text;
	$funName = methodName;
	if (methodName == "main" || metTable.ContainsKey(methodName))
		throw new NotImplementedException("!!!Method overloading is not supported yet!!!");

	MethodData newMet = new MethodData
	{
		name = methodName,
		returnType = ReturnType.Void,
		parser = this
	};
	
	metTable.Add(newMet.name, newMet);
	currentMet = methodName;
	curBlock = newMet;
} LPAREN params[$ID.text] RPAREN;

m_function : m_fun_signature OBRACE code method_return[curBlock.createOperationClass()] CBRACE {

	string methodName = $m_fun_signature.funName;
	
	ReturnType actualReturn;
	
	/*switch($method_return.type)
    {
        case "int":
        	actualReturn = ReturnType.Int;
        	break;
        case "double":
            actualReturn = ReturnType.Double;
            break;
        case "bool":
            actualReturn = ReturnType.Bool;
            break;		
        default:
    		throw new Exception($"Actual return is {$method_return.type}, expected declared return type {metTable[methodName].returnType}");    
    }
	
	

	if (actualReturn != metTable[methodName].returnType){
		throw new Exception($"Actual return is {actualReturn}, expected declared return type {metTable[methodName].returnType}");
	} */
	
	if ($method_return.value == null)
	{
		Error($"null return foeee {methodName}");
	}

	metTable[methodName].returnValue = $method_return.value;

};

m_fun_signature returns [string funName]: FUN_KEYWORD meaningfulType ID {
	
	string methodName = $ID.text;
	$funName = methodName;
	if (methodName == "main" || metTable.ContainsKey(methodName))
		throw new NotImplementedException("!!!Method overloading is not supported yet!!!");

	MethodData newMet = new MethodData
	{
		name = methodName,
		isMeaningful = true,
		parser = this
	};
	
	switch($meaningfulType.text)
    {
    	case "int":
    		newMet.returnType = ReturnType.Int;
    		break;
    	case "double":
            newMet.returnType = ReturnType.Double;
           	break;
        case "bool":
            newMet.returnType = ReturnType.Bool;
            break;		
    }

	metTable.Add(newMet.name, newMet);
	currentMet = methodName;
	curBlock = newMet;
} LPAREN params[$ID.text] RPAREN;

code : (operation[curBlock.createOperationClass()])*;

main_code : (operation[curBlock.createOperationClass()])*;

operation[OperationClass oper] : call[curBlock.ToExpr()] | custom_call[curBlock.ToExpr()] | declare[curBlock.ToExpr()] | ariphExprEx[curBlock.ToExpr()] | boolExprEx[curBlock.ToExpr()]
			| myif[curBlock.ToExpr()]|myif_short[curBlock.ToExpr()]|mywhile[curBlock.ToExpr()]|mydo_while[curBlock.ToExpr()]|myfor[curBlock.ToExpr()];

method_return[OperationClass oper] returns [string type, dynamic value]: RETURN_KEYWORD val_or_id[curBlock.ToExpr()] {
	Debug($"val_or_id3 is {$val_or_id.text}");
	$type = $val_or_id.type;
	$value = $val_or_id.value;
};

params[string funName] : (var_signature[funName] (COMMA var_signature[funName])*)? ;

var_signature[string funName]: meaningfulType ID
				{
					VarData newVar = new VarData();
					newVar.name = $ID.text;
					switch ($meaningfulType.text)
					{
						case "int":
							newVar.type = VarType.Int;
							newVar.value = 0;
							break;
							
						case "double":
							newVar.type = VarType.Double;
							newVar.value = 0.0;
							break;
							
						case "bool":
							newVar.type = VarType.Bool;
							newVar.value = false;
							break;
					}
					ParamData pData = new ParamData();
					pData.name = $ID.text;
					pData.type = newVar.type;
					metTable[funName].paramList.Add(pData);
					metTable[funName].varTable[$ID.text] = newVar;
				};

builtin_func_state returns [ReturnType returnType] : 	'getSelfId' {$returnType = ReturnType.Int;}|
														'getPositionX' {$returnType = ReturnType.Double;}|
														'getPositionY' {$returnType = ReturnType.Double;}|
														'getDirection' {$returnType = ReturnType.Double;}|
														'getHealth' {$returnType = ReturnType.Int;};

builtin_func_p : 'move'|'turn' ;

builtin_func_e : 'hit'|'shoot' ;  

call[ExprClass oper] returns [CallData callData] : parameterized_call[$oper] {

	CallData data = new CallData(){
		callType = CallType.BuiltIn, 
		name = $parameterized_call.text.Substring(0, $parameterized_call.text.IndexOf("(")),
		returnType = $parameterized_call.type,
		parent = curBlock,
		parser = this
	};
	
	string methodName = currentMet;
	if(methodName != "?"){
		curBlock.operations.Add(data);
	}
	
	foreach (var par in _localctx._parameterized_call.call_params().val_or_id())
    	{
    		
    		ParamData d = new ParamData();
    		d.paramType = ParamType.Pass;
    		switch (par.type)
            {
            	case "int":
            		d.type = VarType.Int;		
            		break;
            	case "double":
            		d.type = VarType.Double;
            		break;
            	case "bool":
            		d.type = VarType.Bool;
            		break;
            	//case "other":
            	//	break;
            						
            	default:
            		Error($"Unknown type {par.type}");
            		//throw new NotImplementedException();
            		break;
            }
            d.value = par.value;
            //Debug($"{d.value} of {d.value.GetType()}");
    		data.paramList.Insert(0, d);    
    		Debug($"Adding param, type {d.value.GetType()}");			
    		//data.paramList.Add(d);    			
    	}
		$callData = data;

} | simple_call {

	CallData data = new CallData(){
		callType = CallType.BuiltIn, 
		name = $simple_call.text.Substring(0, $simple_call.text.IndexOf("(")),
		returnType = ReturnType.Void,
        parent = curBlock,
		parser = this
	};
	$callData = data;
	string methodName = currentMet;
	if(methodName != "?"){
		curBlock.operations.Add(data);
	}
};

parameterized_call[ExprClass oper] returns [ExprClass res, ReturnType type]: builtin_func_p LPAREN call_params[$oper] RPAREN {
	$type = ReturnType.Void;
	$res = $oper;
} | builtin_func_state LPAREN call_params[$oper] RPAREN {
    $type = $builtin_func_state.returnType;
    $res = $oper;
};

simple_call : builtin_func_e LPAREN RPAREN;

custom_call[ExprClass oper] returns [string funName, CallData callData]: ID LPAREN call_params[$oper] RPAREN {

	string callName = $ID.text;
	$funName = callName;
	CallData data = new CallData(){
		callType = CallType.Custom, 
		name = callName,
        parent = curBlock,
		parser = this
	};

	foreach (var par in _localctx.call_params().val_or_id())
	{
		
		ParamData d = new ParamData();
		d.paramType = ParamType.Pass;
		switch (par.type)
        {
        	case "int":
        		d.type = VarType.Int;		
        		break;
        	case "double":
        		d.type = VarType.Double;
        		break;
        	case "bool":
        		d.type = VarType.Bool;
        		break;
        	//case "other":
        	//	break;
        						
        	default:
        		Error($"Unknown type {par.type}");
        		//throw new NotImplementedException();
        		break;
        }
        d.value = par.value;
        //Debug($"{d.value} of {d.value.GetType()}");
		data.paramList.Insert(0, d);    
		Debug($"Adding param, type {d.value.GetType()}");			
		//data.paramList.Add(d);    			
	}
	
	string methodName = currentMet;
	$callData = data;
};

call_params[ExprClass oper] : (val_or_id[$oper] {Debug($"val_or_id1 is {$val_or_id.text}");} (COMMA val_or_id[$oper] {Debug($"val_or_id2 is {$val_or_id.text}");})*)?;

val_or_id[ExprClass oper] returns [string type, dynamic value]: 
			ariphExprEx[$oper]
			{
				
				//if($ariphExprEx.res.isEvaluated)
                //		$value = $ariphExprEx.res.value;
                //	else	
                		$value = $ariphExprEx.res;
				
				if ($value.GetType() == typeof(int)) //ariphExprEx.value.GetType() == typeof(int)")
					$type = "int";
				else if ($value.GetType() == typeof(double))
					$type = "double";
				else if ($value.GetType() == typeof(bool))
                    $type = "bool";
                else if ($value.GetType() == typeof(ExprClass))
                	$type = $value.GetType().ToString();
                Debug($"param value1 is {$value} of type {$type}");    
			}
		  | boolExprEx[$oper]
			{
				$value = $boolExprEx.res;
                Debug($"param value2 is {$value}");
				$type = "bool";
			};

//cyclemetka
myif[ExprClass oper]: IF LPAREN boolExprEx[$oper] RPAREN 
     OBRACE 
     {
     	Condition ifer = new Condition()
		{
			cond=$boolExprEx.res,
			parser = this
		};
		curBlock.operations.Add(ifer);
		ifer.cycleBlock.Parent = curBlock;
		curBlock = ifer.cycleBlock;
     }
    (operation[curBlock.createOperationClass()])* 
    CBRACE
     ELSE 
      OBRACE
      {
      	ifer.elseIfBlock.Parent = curBlock.Parent;
      	curBlock = ifer.elseIfBlock;
      } 
    (operation[curBlock.createOperationClass()])*
    CBRACE
    {
        curBlock = curBlock.Parent;
     }
   ;
myif_short[ExprClass oper]: IF LPAREN boolExprEx[$oper] RPAREN 
    OBRACE 
    {
    		Condition ifer = new Condition()
         	{
         		cond=$boolExprEx.res,
				parser = this
         	};
         	curBlock.operations.Add(ifer);
         	ifer.cycleBlock.Parent = curBlock;
         	curBlock = ifer.cycleBlock;
    }
    (operation[curBlock.createOperationClass()])* 
    CBRACE
    {
        curBlock = curBlock.Parent;
    }
   ;
mywhile[ExprClass oper]: WHILE LPAREN boolExprEx[$oper] RPAREN 
     OBRACE 
     {
     	While whiler = new While()
     	{
     		cond=$boolExprEx.res,
			parser = this
     	};
     	curBlock.operations.Add(whiler);
     	whiler.cycleBlock.Parent = curBlock;
     	curBlock = whiler.cycleBlock;
     }
     (operation[curBlock.createOperationClass()])*
     CBRACE 
     {
        curBlock = curBlock.Parent;
      }
       ;
mydo_while[ExprClass oper]: DO 
          OBRACE 
          {
          		Do_while doer = new Do_while();
				doer.parser = this;
               	curBlock.operations.Add(doer);
               	doer.cycleBlock.Parent = curBlock;
               	curBlock = doer.cycleBlock;
          }
            (operation[curBlock.createOperationClass()])* 
          CBRACE
          WHILE LPAREN boolExprEx[$oper] RPAREN 
          {
            	doer.cond=$boolExprEx.res;
            	curBlock = curBlock.Parent;
           }
          ;
myfor[ExprClass oper]: {

	ExprClass fExpr = curBlock.ToExpr();
	ExprClass cExpr = curBlock.ToExpr();
	ExprClass lExpr = curBlock.ToExpr();
	
}  FOR LPAREN (declare[fExpr]
{
	fExpr = $declare.res;
}


|ariphExprEx[fExpr]
{
	fExpr = $ariphExprEx.res;
})
                 SEMICOLON boolExprEx[cExpr] 
                 SEMICOLON l=ariphExprEx[lExpr] RPAREN
        OBRACE
        {
        				For forer = new For()
        				{
                             cond = $boolExprEx.res,
                             first = fExpr,
                             last = $l.res,
							 parser = this
                        };
                        Debug($"cond is {$boolExprEx.text}");
                       	curBlock.operations.Add(forer);
                       	forer.cycleBlock.Parent = curBlock;
                       	curBlock = forer.cycleBlock;
        }
        (operation[curBlock.createOperationClass()])*
        CBRACE
        { 
        	curBlock = curBlock.Parent;    
        }
     ;

//Code related to variables
ariphOperand[ExprClass oper]:
               INT
               {
                   $oper.Push(new ExprStackObject(int.Parse($INT.text), this));
               }
             | DOUBLE
               {
					double value;
               		try 
               		{
                   		value = double.Parse($DOUBLE.text);
                   	} 
                   	catch
                   	{
                   		value = double.Parse($DOUBLE.text.Replace('.', ','));
                   	}
					$oper.Push(new ExprStackObject(value, this));
               }
             | custom_call[$oper]
             	{
             		$oper.Push(new ExprStackObject()
					{
						type = ObjType.Function,
						value = $custom_call.callData,
						parser = this
					});
					Debug("rrigthCall");
             	}
             | call[$oper]
             	{
                    $oper.Push(new ExprStackObject()
             		{
             			type = ObjType.Function,
             			value = $call.callData,
						parser = this
             		});
             		Debug("parrrigthCall");
                }	
             | ariphID[$oper]
               {
                   Console.WriteLine($"founy idd {$ariphID.text} val undefined");
               }
			 | trig[$oper] | trig2[$oper]
			 | incdec=(INC|DEC) ariphID[$oper]
			   {
					$oper.Push(new ExprStackObject()
					{
						type = ObjType.Operation,
						value = $incdec.text + "pre",
						parser = this
					});
			   }
			 | ariphID[$oper] incdec=(INC|DEC)
			   {
					$oper.Push(new ExprStackObject()
					{
						type = ObjType.Operation,
						value = $incdec.text + "post",
						parser = this
					});
			   }
             | LPAREN ariphExprEx[$oper] RPAREN;
ariphTerm[ExprClass oper]:
            ariphOperand[$oper]
            {
                Debug("\t terarpy1 operand\"" + $ariphOperand.text + "\"");
            }
           (muldiv=(MUL|DIV) ariphOperand[$oper])*
            {
				if ($muldiv.text != null)
				{
					$oper.Push(new ExprStackObject()
					 {
						type = ObjType.Operation,
						value = $muldiv.text,
						parser = this
					 });
					Debug("\t terarpy2 operand\"" + $ariphOperand.text + "\"");
				}
            };
ariphExpr[ExprClass oper]:
            ariphTerm[$oper]
            {
                Debug("\t rarpy1 term\"" + $ariphTerm.text + "\"");
            }
			(addsub=(ADD|SUB) ariphTerm[$oper])*
            {
				if ($addsub.text != null)
				{
					$oper.Push(new ExprStackObject()
					 {
						type = ObjType.Operation,
						value = $addsub.text,
						parser = this
					 });
					 Debug("\t rarpy2 term\"" + $ariphTerm.text + "\"");
				}
            };
ariphExprEx[ExprClass oper] returns [ExprClass res]:
            ariphExpr[$oper]
            {
                Debug("\t arpy1 expr\"" + $ariphExpr.text + "\"");
                $res = $oper;
            }
          | ariphID[$oper] assigns=(ASSIGN|ADDASSIGN|SUBASSIGN|MULASSIGN|DIVASSIGN) ariphExprEx[$oper]
            {
                $oper.Push(new ExprStackObject()
					 {
						type = ObjType.Operation,
						value = $assigns.text,
						parser = this
					 });
				$res = $oper;
				Debug("\t arpy2 expr\"" + $text + "\"");
            };

boolOperand[ExprClass oper]:
              BOOL
              {
				  Debug("Const " + $BOOL.text);
                  $oper.Push(new ExprStackObject(bool.Parse($BOOL.text), this));
              }
            | custom_call[$oper]
                          	{
                          		$oper.Push(new ExprStackObject()
             					{
             						type = ObjType.Function,
             						value = $custom_call.callData,
									parser = this
             					});
             					Debug("rrigthCall2");
                          	} 
            | ariphID[$oper]
			  {
				Debug("Var " + $ariphID.text);
			  }
            | ariphExprEx[$oper] comp=(LESS|GREATER|EQUAL|NOTEQUAL|LESSEQUAL|GREQUAL) ariphExprEx[$oper]
              {
				$oper.Push(new ExprStackObject()
				{
					type = ObjType.Operation,
					value = $comp.text,
						parser = this
				}); 
			  }
			| NOT boolOperand[$oper]
			{
				Debug("\tNOT " + $boolOperand.text);
				$oper.Push(new ExprStackObject()
				{
					type = ObjType.Operation,
					value = $NOT.text,
						parser = this
				});
			}
            /*| boolExprEx[$oper] EQUAL boolExprEx[$oper]
              {
                  
              }
            | boolExprEx[$oper] NOTEQUAL boolExprEx[$oper]
              {
                  
              }*/
            | LPAREN boolExprEx[$oper] RPAREN;
boolExpr[ExprClass oper]:
           boolOperand[$oper]
         | left=boolOperand[$oper] andor=(AND|OR) right=boolExpr[$oper]
           {
				Debug("\t" + $left.text + " AND/OR " + $right.text);
				$oper.Push(new ExprStackObject()
				{
					type = ObjType.Operation,
					value = $andor.text,
						parser = this
				});
           };
boolExprEx[ExprClass oper] returns [ExprClass res]:
           boolExpr[$oper]
		   {
				$res = $oper;
		   }
         | left=ariphID[$oper] ASSIGN right=boolExprEx[$oper]
           {
				Debug("\t" + $left.text + " ASSIGN " + $right.text);
				$oper.Push(new ExprStackObject()
				{
					type = ObjType.Operation,
					value = "=",
						parser = this
				});
				$res = $oper;
           };

//declaration
declare[ExprClass oper] returns [ExprClass res]: INTKEY ariphID[$oper]
          {
           VarData newVar = new VarData
           {
                type = VarType.Int,
                value = 0
           };
           curBlock.varTable.Add($ariphID.text, newVar);
           Debug("Create var " + $ariphID.text);
          }
          (ASSIGN ariphExprEx[$oper])?
          {
           if ($ariphExprEx.text != null)
           {
				Debug("\tAssigning it value of " + $ariphExprEx.text);
				$oper.Push(new ExprStackObject()
					 {
						type = ObjType.Operation,
						value = "=",
						parser = this
					 });
           }
           $res = $oper;
          }
          
        | DOUBLEKEY ariphID[$oper]
          {
           VarData newVar = new VarData
           {
                type = VarType.Double,
                value = 0.0
           };
           curBlock.varTable.Add($ariphID.text, newVar);
           Debug("Create var " + $ariphID.text);
          }
          (ASSIGN ariphExprEx[$oper])?
          {
           if ($ariphExprEx.text != null)
           {
                Debug("\tAssigning it value of " + $ariphExprEx.text);
                $oper.Push(new ExprStackObject()
					 {
						type = ObjType.Operation,
						value = "=",
						parser = this
					 });
           }
           $res = $oper;
          }
        | BOOLKEY ariphID[$oper]
          {
           VarData newVar = new VarData
           {
                type = VarType.Bool,
                value = false
           };
           curBlock.varTable.Add($ariphID.text, newVar);
           Debug("Create var " + $ariphID.text);
          }
          (ASSIGN boolExprEx[$oper])?
          {
           if ($boolExprEx.text != null)
           {
                Debug("\tAssigning3 it value of " + $boolExprEx.text);
                $oper.Push(new ExprStackObject()
				{
					type = ObjType.Operation,
					value = "=",
						parser = this
				});
           }
           $res = $oper;
          };

ariphID[ExprClass oper] : ID
		{
			$oper.Push(new ExprStackObject()
					 {
						type = ObjType.Var,
						value = $ID.text,
						parser = this
					 });
			Debug($"arrriph id {$ID.text}");
			
			//$oper.Push(new ExprStackObject()
            //					 {
            //						type = ObjType.Var,
            //						value = $ID.text,
			//			parser = this
            //					 });
            //			Debug($"boooooool id {$ID.text}");
			
		};

//trigonometry
trig[ExprClass oper]:
		trfun=(SIN|COS|TAN|ASIN|ACOS|ATAN) LPAREN ariphExprEx[$oper] RPAREN
		{
			$oper.Push(new ExprStackObject()
					 {
						type = ObjType.Operation,
						value = $trfun.text,
						parser = this
					 });
		};
trig2[ExprClass oper]:
		ATAN2 LPAREN ariphExprEx[$oper] COMMA ariphExprEx[$oper] RPAREN
		{
			$oper.Push(new ExprStackObject()
					 {
						type = ObjType.Operation,
						value = "atan2",
						parser = this
					 });
		};
		

//code related to cycles



//Lexer rules
//OPSEP   : '\n' ;
SEMICOLON: ';';

//keywords
INTKEY      : 'int' ;
DOUBLEKEY   : 'double' ;
BOOLKEY     : 'bool' ;
WHILE		: 'while' ;
FOR			: 'for' ;
DO			: 'do' ;
IF			: 'if' ;
ELSE		: 'else' ;
SIN			: 'sin' ;
COS			: 'cos' ;
TAN			: 'tan' ;
ASIN		: 'asin' ;
ACOS		: 'acos' ;
ATAN		: 'atan' ;
ATAN2		: 'atan2' ;

//operators
ADD     : '+' ;
SUB     : '-' ;
MUL     : '*' ;
DIV     : '/' ;
INC		: '++' ;
DEC		: '--' ;
ASSIGN		: '=' ;
ADDASSIGN   : '+=' ;
SUBASSIGN   : '-=' ;
MULASSIGN   : '*=' ;
DIVASSIGN   : '/=' ;
AND       : '&&' ;
OR        : '||' ;
NOT		  : '!' ;
LESS      : '<' ;
GREATER   : '>' ;
EQUAL     : '==' ;
NOTEQUAL  : '!=' ;
LESSEQUAL : '<=' ;
GREQUAL   : '>=' ;

//Whitespace symbols
WS : [ \t\r\n]+ -> skip ;

//literals
BOOL    : ('true'|'false') ;
DOUBLE  : [+-]?DIGIT*[.]DIGIT+ ;
INT     : [+-]?DIGIT+ ;

RETURN_KEYWORD : 'return';
PASS : 'pass' ;

MAIN : 'main' ;

FUN_KEYWORD : 'fun' ;

meaningfulType : ('int'|'double'|'bool') ;

VOID : 'void' ;

COMMA : ',' ;

OBRACE : '{' ;
CBRACE : '}' ;

LPAREN : '(' ;
RPAREN : ')' ;

COMMENT : '//'.*?[\n] -> skip ;

STRING : '"'[a-zA-Z]*'"' ;
ID  : LETTER (LETTER | DIGIT)* ;

//lexer rule fragments
fragment LETTER : [a-zA-Z_] ;
fragment DIGIT : [0-9] ;