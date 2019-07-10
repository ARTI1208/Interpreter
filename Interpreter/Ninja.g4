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

    public class MethodData
    {
        public string name;
		public bool isMeaningful;
        public ReturnType returnType;
        public ArrayList<NinjaParser.ParamData> paramList = new ArrayList<NinjaParser.ParamData>();
        public List<CallData> callList = new ArrayList<CallData>();
        
		public dynamic returnValue;
		
		public Dictionary<string, VarData> varTable = new Dictionary<string, VarData>();
        
        public override string ToString()
        {
        	return $"fun {returnType} {name}, params : {paramList} ";
        }
    }
 
 	public static Dictionary<string, VarData> varTable = new Dictionary<string, VarData>();
    public static Dictionary<string, MethodData> metTable = new Dictionary<string, MethodData>();
    int depth = 0;
    static string currentMet = "?";
    
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
	
	public static bool CheckParams(NinjaParser.CallData call, NinjaParser.MethodData method)
    {
    	Console.WriteLine($"Checking params of {call.name}");
    	if (call.paramList.Count != method.paramList.Count)
    	{
    		Console.WriteLine($"Expected params {method.paramList.Count}, found {call.paramList.Count}");
    		return false;
    	}
    
    	for (int i = 0; i < call.paramList.Count; i++)
    	{
    				
    		if (call.paramList[i].type == method.paramList[i].type)
    		{
    			method.paramList[i].value = call.paramList[i].value;
    			method.varTable[method.paramList[i].name].value = call.paramList[i].value;
    			Console.WriteLine($"addf var {method.paramList[i].name}, val {method.varTable[method.paramList[i].name].value}");
    		}
    		else
    		{
    			Console.WriteLine($"Type mismatch: expected {method.paramList[i].type}, found {call.paramList[i].type} with value {call.paramList[i].value}");
    			return false;
    		}
    	}
    
    	return true;
    }
            		
	static ArrayList<byte> _bytes = new ArrayList<byte>();
	
	static string ParamListToString(ArrayList<NinjaParser.ParamData> list)
    {
    	string s = "{";
    	foreach (var data in list)
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
    
    	s = (s.Length > 1 ? s.Substring(0, s.Length - 1) : s) + " }";
    	return s;
    }
	
	public class Block
	{
		public List<OperationClass> operations = new List<OperationClass>();
		public Dictionary<string, VarData> varTable = new Dictionary<string, VarData>();
		
		public void Eval()
		{
			for (int i = 0; i < operations.Count; ++i)
				operations[i].Eval();
		}
		
		public OperationClass createOperationClass()
		{
			operations.Add(new OperationClass());
			return operations[operations.Count - 1];
		}
		
		public AriphExprClass ToAriphExpr()
		{
			int lastInd = operations.Count - 1;
			var res = new AriphExprClass(operations[lastInd]);
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
			
		public ArrayList<NinjaParser.ParamData> paramList = new ArrayList<NinjaParser.ParamData>();
		
		public override dynamic Eval()
		{
			if (callType == NinjaParser.CallType.Custom)
			{
				if (NinjaParser.metTable.ContainsKey(name) && CheckParams(this, NinjaParser.metTable[name]))
				{
					//GoThroughCalls(NinjaParser.metTable[call.name]);
					foreach(var sm in NinjaParser.metTable[name].callList)
					{
						sm.Eval();
					}
				}
			}
			else
			{
				Console.WriteLine($"Calling builtin method {name} with params {ParamListToString(paramList)}");
				//					Console.WriteLine(call.name);
				switch (name)
				{
					case "move":
				//							Console.WriteLine($"move byte");
						_bytes.Add(1);
						break;
					case "turn":
				//							Console.WriteLine("turn byte");
						_bytes.Add(2);
						break;
					case "hit":
				//							Console.WriteLine($"hit byte");
						_bytes.Add(3);
						break;
					case "shoot":
				//							Console.WriteLine($"shoot byte");
						_bytes.Add(4);
						break;
					default:
						Console.WriteLine($"no byte for this op {name}");
						break;
				}
			}
			return null;
		}
	}
	
	public static Block curBlock = new Block();
	
	public class OperationClass
	{
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
		Number, Logic, Var, Operation
	}

	public class ExprStackObject
	{
		public ObjType type;
		public dynamic value;
		
		public ExprStackObject(): this(0) { }
		
		public ExprStackObject(double value)
		{
			type = ObjType.Number;
			this.value = value;
		}

		public ExprStackObject(int value)
		{
			type = ObjType.Number;
			this.value = value;
		}
		
		public ExprStackObject(bool value)
		{
			type = ObjType.Number;
			this.value = value;
		}
		
		public dynamic Calc()
		{
			if (type == ObjType.Number)
				return value;
			if (type == ObjType.Var)
				return curBlock.varTable[value].value;
			Error("\"" + value + "\" is an operation");
			return null;
		}
	}
	
	public class AriphExprClass : OperationClass
	{
		public List<ExprStackObject> exprStack;
		
		public AriphExprClass(OperationClass parent) : base(parent)
		{
			exprStack = new List<ExprStackObject>();
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
		
		public override dynamic Eval()
		{
			List<ExprStackObject> stack = new List<ExprStackObject>();
			foreach (var elem in exprStack)
			{
				if (elem.type == ObjType.Number || elem.type == ObjType.Var)
					stack.Add(elem);
				else
				{
					ExprStackObject left, right;
					switch (elem.value)
					{
						case "+":
							right = Pop(stack);
							left = Pop(stack);
							stack.Add(new ExprStackObject(left.Calc() + right.Calc()));
							break;
						
						case "-":
							right = Pop(stack);
							left = Pop(stack);
							stack.Add(new ExprStackObject(left.Calc() - right.Calc()));
							break;
						
						case "*":
							right = Pop(stack);
							left = Pop(stack);
							stack.Add(new ExprStackObject(left.Calc() * right.Calc()));
							break;
						
						case "/":
							right = Pop(stack);
							left = Pop(stack);
							stack.Add(new ExprStackObject(left.Calc() / right.Calc()));
							break;
						
						case "=":
							right = Pop(stack);
							left = Pop(stack);
							try
							{
								dynamic rightval = right.Calc();
								VarData data = curBlock.varTable[left.value];
								if (data.value.GetType() == rightval.GetType())
									data.value = rightval;
								else if (data.type == VarType.Double)
									data.value = (double)rightval;
								else
									Error("Can't convert \"" + "" + "\" to Int");
								stack.Add(new ExprStackObject(data.value));
							}
							catch (KeyNotFoundException)
							{
								Error("Variable " + left.value + " does not exist in current context");
							}
							break;
						
						case "+=":
							right = Pop(stack);
							left = Pop(stack);
							try
							{
								dynamic rightval = right.Calc();
								VarData data = curBlock.varTable[left.value];
								if (data.value.GetType() == rightval.GetType())
									data.value += rightval;
								else if (data.type == VarType.Double)
									data.value += (double)rightval;
								else
									Error("Can't convert \"" + "" + "\" to Int");
								stack.Add(new ExprStackObject(data.value));
							}
							catch (KeyNotFoundException)
							{
								Error("Variable " + left.value + " does not exist in current context");
							}
							break;
						
						case "-=":
							right = Pop(stack);
							left = Pop(stack);
							try
							{
								dynamic rightval = right.Calc();
								VarData data = curBlock.varTable[left.value];
								if (data.value.GetType() == rightval.GetType())
									data.value -= rightval;
								else if (data.type == VarType.Double)
									data.value -= (double)rightval;
								else
									Error("Can't convert \"" + "" + "\" to Int");
								stack.Add(new ExprStackObject(data.value));
							}
							catch (KeyNotFoundException)
							{
								Error("Variable " + left.value + " does not exist in current context");
							}
							break;
						
						case "*=":
							right = Pop(stack);
							left = Pop(stack);
							try
							{
								dynamic rightval = right.Calc();
								VarData data = curBlock.varTable[left.value];
								if (data.value.GetType() == rightval.GetType())
									data.value *= rightval;
								else if (data.type == VarType.Double)
									data.value *= (double)rightval;
								else
									Error("Can't convert \"" + "" + "\" to Int");
								stack.Add(new ExprStackObject(data.value));
							}
							catch (KeyNotFoundException)
							{
								Error("Variable " + left.value + " does not exist in current context");
							}
							break;
						
						case "/=":
							right = Pop(stack);
							left = Pop(stack);
							try
							{
								dynamic rightval = right.Calc();
								VarData data = curBlock.varTable[left.value];
								if (data.value.GetType() == rightval.GetType())
									data.value /= rightval;
								else if (data.type == VarType.Double)
									data.value /= (double)rightval;
								else
									Error("Can't convert \"" + "" + "\" to Int");
								stack.Add(new ExprStackObject(data.value));
							}
							catch (KeyNotFoundException)
							{
								Error("Variable " + left.value + " does not exist in current context");
							}
							break;
					}
					
				}
			}
			var res = stack[0];
			res.Calc();
			return res.value;
		}
	}
	
	public class BoolExpr : OperationClass
	{
		public List<ExprStackObject> exprStack;
		
		public BoolExpr(OperationClass parent) : base(parent)
		{
			exprStack = new List<ExprStackObject>();
		}
		
		public ExprStackObject Pop()
		{
			var ret = exprStack[exprStack.Count - 1];
			exprStack.RemoveAt(exprStack.Count - 1);
			return ret;
		}
		
		public void Push(ExprStackObject value)
		{
			exprStack.Add(value);
		}
		
		public override dynamic Eval()
		{
			List<ExprStackObject> stack = new List<ExprStackObject>();
			/*foreach (var elem in exprStack)
			{
				if (elem.type == ObjType.Number || elem.type == ObjType.Var)
					stack.Add(elem);
				else
				{
					ExprStackObject left, right;
					switch (elem.value)
					{
						
					}
					
				}
			}*/
			var res = stack[0];
			res.Calc();
			return res.value;
		}
	}
}

program : function* main function* {

/*if (NinjaParser.metTable.ContainsKey("main"))
                	{
                		++depth;
                		//GoThroughCalls(NinjaParser.metTable[call.name]);
                		foreach(var sm in NinjaParser.metTable["main"].callList)
                		{
                			sm.Eval();
                		}
                	}*/

};

main : main_signature OBRACE main_code CBRACE
{
	curBlock.Eval();
};

main_signature : FUN_KEYWORD VOID MAIN LPAREN RPAREN {
	MethodData newMet = new MethodData
	{
		name = "main",
		returnType = ReturnType.Void
	};
	metTable.Add("main", newMet);
	currentMet = "main";
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
		returnType = ReturnType.Void
	};
	
	metTable.Add(newMet.name, newMet);
	currentMet = methodName;
} LPAREN params[$ID.text] RPAREN;

m_function : m_fun_signature OBRACE code method_return CBRACE {

	string methodName = $m_fun_signature.funName;
	
	ReturnType actualReturn;
	
	switch($method_return.type)
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
    		throw new NotImplementedException();     
    }

	if (actualReturn != metTable[methodName].returnType){
		throw new Exception($"Actual return is {actualReturn}, expected declared return type {metTable[methodName].returnType}");
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
		isMeaningful = true
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

} LPAREN params[$ID.text] RPAREN;

code : (operation[curBlock.createOperationClass()])*;

main_code : (operation[curBlock.createOperationClass()])*;

operation[OperationClass oper] : call[$oper] | custom_call[$oper] | declare[curBlock.ToAriphExpr()] | ariphExprEx[curBlock.ToAriphExpr()] | boolExprEx
			| myif|myif_short|mywhile|mydo_while|myfor;

method_return returns [string type, dynamic value]: RETURN_KEYWORD val_or_id[curBlock.createOperationClass()] {
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

builtin_func_p : 'move'|'turn' ;

builtin_func_e : 'hit'|'shoot' ;  

call[OperationClass oper] : parameterized_call {

	CallData data = new CallData(){
		callType = CallType.BuiltIn, 
		name = $parameterized_call.text.Substring(0, $parameterized_call.text.IndexOf("(")),
		returnType = ReturnType.Void
	};
	ParamData d = new ParamData()
	{
		type = VarType.Double, 
		value = _localctx._parameterized_call.ariphExprEx().GetText()
	};
    d.paramType = ParamType.Pass;				
    data.paramList.Add(d);
	
	string methodName = currentMet;
	if(methodName != "?"){
		metTable[methodName].callList.Add(data);
	}

} | simple_call {

	CallData data = new CallData(){
		callType = CallType.BuiltIn, 
		name = $simple_call.text.Substring(0, $simple_call.text.IndexOf("(")),
		returnType = ReturnType.Void
	};

	string methodName = currentMet;
	if(methodName != "?"){
		metTable[methodName].callList.Add(data);
	}
};

parameterized_call : builtin_func_p LPAREN ariphExprEx[new AriphExprClass(curBlock.createOperationClass())] RPAREN ;

simple_call : builtin_func_e LPAREN RPAREN;

custom_call[OperationClass oper] returns [string funName]: ID LPAREN call_params[$oper] RPAREN {

	string callName = $ID.text;
	$funName = callName;
	CallData data = new CallData(){
		callType = CallType.Custom, 
		name = callName
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
        		throw new NotImplementedException();
        }
        d.value = par.value;
		data.paramList.Add(d);    			
	}
	
	string methodName = currentMet;
    if(methodName != "?" && CheckParams(data, metTable[callName])){
    	metTable[methodName].callList.Add(data);
    }

};

call_params[OperationClass oper] : (val_or_id[$oper] (COMMA val_or_id[$oper])*)?;

val_or_id[OperationClass oper] returns [string type, dynamic value]: 
			ariphExprEx[curBlock.ToAriphExpr()]
			{
				$value = 0;
				if (false) //ariphExprEx.value.GetType() == typeof(int)")
					$type = "int";
				else
					$type = "double";
			}
		  | boolExprEx
			{
				$value = false;
				$type = "bool";
			};


//Code related to variables
ariphOperand[AriphExprClass oper]:
               INT
               {
                   $oper.Push(new ExprStackObject(int.Parse($INT.text)));
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
					$oper.Push(new ExprStackObject(value));
               }
             | custom_call[$oper]
             	/*{
             		$value = metTable[$custom_call.funName].returnValue;
             	}*/
             | ariphID[$oper]
               {
                   Console.WriteLine($"founy idd {$ariphID.text} val undefined");
               }
             /*| LPAREN ariphExprEx[null] RPAREN
               {
                   $value = $ariphExprEx[null].value;
               }*/;
ariphTerm[AriphExprClass oper]:
            ariphOperand[$oper]
            {
                Debug("\t terarpy1 operand\"" + $ariphOperand.text + "\"");
            }
           (MUL ariphOperand[$oper])*
            {
				if ($MUL.text != null)
				{
					$oper.Push(new ExprStackObject()
					 {
						type = ObjType.Operation,
						value = $MUL.text
					 });
					Debug("\t terarpy2 operand\"" + $ariphOperand.text + "\"");
				}
            };
ariphExpr[AriphExprClass oper]:
            ariphTerm[$oper]
            {
                Debug("\t rarpy1 term\"" + $ariphTerm.text + "\"");
            }
           (ADD ariphTerm[$oper])*
            {
				if ($ADD.text != null)
				{
					$oper.Push(new ExprStackObject()
					 {
						type = ObjType.Operation,
						value = $ADD.text
					 });
					 Debug("\t rarpy2 term\"" + $ariphTerm.text + "\"");
				 }
            };
ariphExprEx[AriphExprClass oper]:
            ariphExpr[$oper]
            {
                Debug("\t arpy1 expr\"" + $ariphExpr.text + "\"");
            }
          | ariphID[$oper] ASSIGN ariphExprEx[$oper]
            {
                $oper.Push(new ExprStackObject()
					 {
						type = ObjType.Operation,
						value = "="
					 });
				Debug("\t arpy2 expr\"" + $ariphExprEx.text + "\"");
            };

boolOperand returns[bool value]/*[BoolExpr oper]*/:
              BOOL
              /*{
                  //$oper.Push(new ExprStackObject($BOOL.text));
              }*/
            | ID
              /*{
                  $oper.Push(new ExprStackObject()
				  {
						type = ObjType.var;
						
				  });
              }*/
            | left=ariphExprEx[null] LESS right=ariphExprEx[null]
              /*{
                  $value = $left.value < $right.value;
              }*/
            | left=ariphExprEx[null] GREATER right=ariphExprEx[null]
              /*{
                  $value = $left.value > $right.value;
              }*/
            | left=ariphExprEx[null] EQUAL right=ariphExprEx[null]
              /*{
                  $value = $left.value == $right.value;
              }*/
            | left=ariphExprEx[null] NOTEQUAL right=ariphExprEx[null]
              /*{
                  $value = $left.value != $right.value;
              }*/
            | left=ariphExprEx[null] LESSEQUAL right=ariphExprEx[null]
              /*{
                  $value = $left.value <= $right.value;
              }*/
            | left=ariphExprEx[null] GREQUAL right=ariphExprEx[null]
              /*{
                  $value = $left.value >= $right.value;
              }*/
            /*| leftBool=boolExprEx EQUAL rightBool=boolExprEx
              {
                  $value = $leftBool.value == $rightBool.value;
              }
            | leftBool=boolExprEx NOTEQUAL rightBool=boolExprEx
              {
                  $value = $leftBool.value != $rightBool.value;
              }*/
            | LPAREN boolExprEx RPAREN
              {
                  $value = $boolExprEx.value;
              };
boolExpr returns [bool value]:
           boolOperand
           {
               $value = $boolOperand.value;
           }
         | left=boolOperand OR right=boolExpr
           {
               $value = $left.value || $right.value;
           }
         | left=boolOperand AND right=boolExpr
           {
               $value = $left.value && $right.value;
           };
boolExprEx returns [bool value]:
           boolExpr
           {
              $value = $boolExpr.value;
           }
         | ID ASSIGN boolExprEx
           {
              try
              {
                VarData data = curBlock.varTable[$ID.text];
                $value = data.value = $boolExprEx.value;
                if (data.type != VarType.Bool)
                {
                    Error("Can't convert " + data.type + " to Bool");
                }
              }
              catch (KeyNotFoundException)
              {
                Error("Variable " + $ID.text + " does not exist in current context");
              }
           };

//declaration
declare[AriphExprClass oper]: INTKEY ariphID[$oper]
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
						value = "="
					 });
           }
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
						type = ObjType.Var,
						value = "="
					 });
           }
          }
        | BOOLKEY ID
          {
           VarData newVar = new VarData
           {
                type = VarType.Bool,
                value = false
           };
           curBlock.varTable.Add($ID.text, newVar);
           Debug("Create var " + $ID.text);
          }
          (ASSIGN boolExprEx)?
          {
           if ($boolExprEx.text != null)
           {
                Debug("\tAssigning3 it value of " + $boolExprEx.text);
                try
                {
                  curBlock.varTable[$ID.text].value = $boolExprEx.value;
                }
                catch (KeyNotFoundException)
                {
                  Error("Variable " + $ID.text + " does not exist in cyrrent context");
                }
           }
          };

ariphID[AriphExprClass oper] : ID
		{
			$oper.Push(new ExprStackObject()
					 {
						type = ObjType.Var,
						value = $ID.text
					 });
		};

//trigonometry
sin returns [double value]:
		SIN LPAREN ariphExprEx[null] RPAREN
		/*{
			$value = Math.Sin($ariphExprEx[null].value);
		}*/;
cos returns [double value]:
		COS LPAREN ariphExprEx[null] RPAREN
		/*{
			$value = Math.Cos($ariphExprEx[null].value);
        }*/;
tan returns [double value]:
		TAN LPAREN ariphExprEx[null] RPAREN
		/*{
			$value = Math.Tan($ariphExprEx[null].value);
		}*/;
asin returns [double value]:
		ASIN LPAREN ariphExprEx[null] RPAREN
		/*{
			$value = Math.Asin($ariphExprEx[null].value);
		}*/;
acos returns [double value]:
		ACOS LPAREN ariphExprEx[null] RPAREN
		/*{
			$value = Math.Acos($ariphExprEx[null].value);
		}*/;
atan returns [double value]:
		ATAN LPAREN ariphExprEx[null] RPAREN
		/*{
			$value = Math.Atan($ariphExprEx[null].value);
		}*/;
atan2 returns [double value]:
		ATAN2 LPAREN y=ariphExprEx[null] COMMA x=ariphExprEx[null] RPAREN
		/*{
			$value = Math.Atan2($y.value, $x.value);
		}*/;
		

//code related to cycles
myif: IF LPAREN boolExprEx RPAREN // вместо INT  нужен BOOL
     OBRACE 
    (operation[null])+
    CBRACE
     ELSE 
      OBRACE  
    (operation[null])+
    CBRACE
   ;
myif_short: IF LPAREN boolExprEx  RPAREN // вместо INT  нужен BOOL
    OBRACE
    (operation[null])+
    CBRACE
   ;
mywhile: WHILE LPAREN boolExprEx RPAREN // вместо INT  нужен BOOL
     OBRACE
     (operation[null])+
     CBRACE 
       ;
mydo_while: DO 
          OBRACE
            (operation[null])+
          CBRACE
          WHILE LPAREN boolExprEx RPAREN // вместо INT  нужен BOOL
          ;
myfor:  FOR LPAREN ~SEMICOLON+ SEMICOLON boolExprEx SEMICOLON ~SEMICOLON+ RPAREN // ~SEMICOLON+ заменяется на INT BOOL оператор
        OBRACE
        (operation[null])+
        CBRACE
     ;


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
ADDSUB	: ADD | SUB ;
MUL     : '*' ;
DIV     : '/' ;
MULDIV	: MUL | DIV ;
ASSIGN		: '=' ;
ADDASSIGN   : '+=' ;
SUBASSIGN   : '-=' ;
MULASSIGN   : '*=' ;
DIVASSIGN   : '/=' ;
ASSIGNS		: ASSIGN | ADDASSIGN | SUBASSIGN | MULASSIGN | DIVASSIGN ;
AND       : '&&' ;
OR        : '||' ;
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
DOUBLE  : [+-]?DIGIT*[,.]DIGIT+ ;
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