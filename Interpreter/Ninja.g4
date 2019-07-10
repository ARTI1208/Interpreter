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
	
	public class CallData
	{
		public string name;
            
		public dynamic value;
            
		public CallType callType;
    	
		public ReturnType returnType;
    		
		public ArrayList<NinjaParser.ParamData> paramList = new ArrayList<NinjaParser.ParamData>();	
    	
    	public override string ToString()
        {
			return $"call {name} of type {callType} returns {returnType}, params : {paramList}";
		}
	}

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
    		
    public void GoThroughCalls(NinjaParser.MethodData methodData)
    {
        string formatter = new string('\t', depth);
        Console.WriteLine($"{formatter}--Entering method {methodData.name}, params {ParamListToString(methodData.paramList)}:");
        Console.WriteLine($"{formatter}===Variables of the met:===");
        foreach (var elem in methodData.varTable)
        {
            Console.WriteLine("\t"+ formatter + elem.Key + " is " + elem.Value.type + " with value " + elem.Value.value);
        }
        Console.WriteLine($"{formatter}===Variables of the met:===");
        
        foreach (var call in methodData.callList)
        {
            if (call.callType == NinjaParser.CallType.Custom)
            {
            	if (NinjaParser.metTable.ContainsKey(call.name))
            	{
            		++depth;
					//foreach (var param in call.paramList)
					//{
					//	VarData data = varTable[param.name];
					//	if (data.type == param.type)
					//		data.value = param.value;
					//	else if (data.type == VarType.Double && param.type == VarType.Int)
					//		data.value = (double)param.value;
					//	else
					//		Error("Can't convert \"" + param.value.ToString() + "\" to " + data.type);
					//}
            		GoThroughCalls(NinjaParser.metTable[call.name]);
            	}
            }
            else
            {
            	Console.WriteLine($"{formatter}Calling builtin method {call.name} with params {ParamListToString(call.paramList)}");
            	//Console.WriteLine(call.name);
            	switch (call.name)
            	{
            		case "move":
            			//Console.WriteLine($"move byte");
            			_bytes.Add(1);
            			break;
            		case "turn":
    			        //Console.WriteLine("turn byte");
            			_bytes.Add(2);
            			break;
            		case "hit":
            			//Console.WriteLine($"hit byte");
            			_bytes.Add(3);
            			break;
            		case "shoot":
            			//Console.WriteLine($"shoot byte");
            			_bytes.Add(4);
            			break;
            		default:
            			Console.WriteLine($"no byte for this op {call.name}");
            			break;
            	}
            }
        }
            
        if (methodData.isMeaningful)
        {
            Console.WriteLine($"{formatter}Returning {methodData.returnValue} of type {methodData.returnType}");
        }
        --depth;
        Console.WriteLine($"{formatter}--Exiting method {methodData.name}");
    }
            		
	ArrayList<byte> _bytes = new ArrayList<byte>();
	
	string ParamListToString(ArrayList<NinjaParser.ParamData> list)
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
}

program : function* main function* {

GoThroughCalls(NinjaParser.metTable["main"]);

};

main : main_signature OBRACE main_code CBRACE;

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

code : (operation)*;

main_code : (operation)*;

operation : call | custom_call | declare | ariphExprEx | boolExprEx
			| myif|myif_short|mywhile|mydo_while|myfor;

method_return returns [string type, dynamic value]: RETURN_KEYWORD val_or_id {
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

call : parameterized_call {

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

parameterized_call : builtin_func_p LPAREN ariphExprEx RPAREN ;

simple_call : builtin_func_e LPAREN RPAREN;

custom_call returns [string funName]: ID LPAREN call_params RPAREN {

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

call_params : (val_or_id (COMMA val_or_id)*)?;

val_or_id returns [string type, dynamic value]: 
			ariphExprEx
			{
				$value = $ariphExprEx.value;
				if ($ariphExprEx.value.GetType() == typeof(int))
					$type = "int";
				else
					$type = "double";
			}
		  | boolExprEx
			{
				$value = $boolExprEx.value;
				$type = "bool";
			};


//Code related to variables
ariphOperand returns [dynamic value]:
               INT
               {
                   $value = int.Parse($INT.text);
               }
             | DOUBLE
               {
               		try 
               		{
                   		$value = double.Parse($DOUBLE.text);
                   	} 
                   	catch
                   	{
                   		$value = double.Parse($DOUBLE.text.Replace('.', ','));
                   	}	
               }
             | custom_call
             	{
             		$value = metTable[$custom_call.funName].returnValue;
             	}  
             | ID
               {
                   try
                   {
                     $value = metTable[currentMet].varTable[$ID.text].value;
                     Console.WriteLine($"founy idd {$ID.text} val {$value}");
                   }
                   catch (KeyNotFoundException)
                   {
                     Error("Variable " + $ID.text + " does not exist in current context");
                   }
               }  
			 | sin
			   {
				   $value = $sin.value;
			   }
			 | cos
			   {
				   $value = $cos.value;
			   }
			 | tan
			   {
				   $value = $tan.value;
			   }
			 | asin
			   {
				   $value = $asin.value;
			   }
			 | acos
			   {
				   $value = $acos.value;
			   }
			 | atan
			   {
				   $value = $atan.value;
			   }
			 | atan2
			   {
				   $value = $atan2.value;
			   }
             | LPAREN ariphExprEx RPAREN
               {
                   $value = $ariphExprEx.value;
               };
ariphTerm returns [dynamic value]:
            ariphOperand
            {
                $value = $ariphOperand.value;
                Debug("\t terarpy1");
            }
          | left=ariphTerm MUL right=ariphOperand
            {
                $value = $left.value * $right.value;
                Debug("\t terarpy2");
            }
          | left=ariphTerm DIV right=ariphOperand
            {
                $value = $left.value / $right.value;
                Debug("\t terarpy3");
            };
ariphExpr returns [dynamic value]:
            ariphTerm
            {
                $value = $ariphTerm.value;
                Debug("\t rarpy1");
            }
          | left=ariphExpr ADD right=ariphTerm
            {
                $value = $left.value + $right.value;
            }
          | left=ariphExpr SUB right=ariphTerm
            {
                $value = $left.value - $right.value;
            };
ariphExprEx returns [dynamic value]:
            ariphExpr
            {
                $value = $ariphExpr.value;
                Debug("\t arpy1"); 
            }
          | ID ASSIGN ariphExprEx
            {
                try
                {
                    VarData data = metTable[currentMet].varTable[$ID.text];
                    if (data.value.GetType() == $ariphExprEx.value.GetType())
                        data.value = $ariphExprEx.value;
                    else if (data.type == VarType.Double)
                        data.value = (double)$ariphExprEx.value;
                    else
                        Error("Can't convert \"" + $ariphExprEx.text + "\" to Int");
                        
                }
                catch (KeyNotFoundException)
                {
                  Error("Variable " + $ID.text + " does not exist in current context");
                }
            }
          | ID ADDASSIGN ariphExprEx
            {
                try
                {
                    VarData data = metTable[currentMet].varTable[$ID.text];
                    if (data.value.GetType() == $ariphExprEx.value.GetType())
                        data.value += $ariphExprEx.value;
                    else if (data.type == VarType.Double)
                        data.value += (double)$ariphExprEx.value;
                    else
                        Error("Can't convert \"" + $ariphExprEx.text + "\" to Int");
                }
                catch (KeyNotFoundException)
                {
                  Error("Variable " + $ID.text + " does not exist in current context");
                }
            }
          | ID SUBASSIGN ariphExprEx
            {
                try
                {
                    VarData data = metTable[currentMet].varTable[$ID.text];
                    if (data.value.GetType() == $ariphExprEx.value.GetType())
                        data.value -= $ariphExprEx.value;
                    else if (data.type == VarType.Double)
                        data.value -= (double)$ariphExprEx.value;
                    else
                        Error("Can't convert \"" + $ariphExprEx.text + "\" to Int");
                }
                catch (KeyNotFoundException)
                {
                  Error("Variable " + $ID.text + " does not exist in current context");
                }
            }
          | ID MULASSIGN ariphExprEx
            {
                try
                {
                    VarData data = metTable[currentMet].varTable[$ID.text];
                    if (data.value.GetType() == $ariphExprEx.value.GetType())
                        data.value *= $ariphExprEx.value;
                    else if (data.type == VarType.Double)
                        data.value *= (double)$ariphExprEx.value;
                    else
                        Error("Can't convert \"" + $ariphExprEx.text + "\" to Int");
                }
                catch (KeyNotFoundException)
                {
                  Error("Variable " + $ID.text + " does not exist in current context");
                }
            }
          | ID DIVASSIGN ariphExprEx
            {
                try
                {
                    VarData data = metTable[currentMet].varTable[$ID.text];
                    if (data.value.GetType() == $ariphExprEx.value.GetType())
                        data.value /= $ariphExprEx.value;
                    else if (data.type == VarType.Double)
                        data.value /= (double)$ariphExprEx.value;
                    else
                        Error("Can't convert \"" + $ariphExprEx.text + "\" to Int");
                }
                catch (KeyNotFoundException)
                {
                  Error("Variable " + $ID.text + " does not exist in current context");
                }
            };

boolOperand returns [bool value]:
              BOOL
              {
                  $value = bool.Parse($BOOL.text);
              }
            | ID
              {
                  try
                  {
                      $value = metTable[currentMet].varTable[$ID.text].value;
                  }
                  catch (KeyNotFoundException)
                  {
                    Error("Variable " + $ID.text + " does not exist in current context");
                  }
              }
            | left=ariphExprEx LESS right=ariphExprEx
              {
                  $value = $left.value < $right.value;
              }
            | left=ariphExprEx GREATER right=ariphExprEx
              {
                  $value = $left.value > $right.value;
              }
            | left=ariphExprEx EQUAL right=ariphExprEx
              {
                  $value = $left.value == $right.value;
              }
            | left=ariphExprEx NOTEQUAL right=ariphExprEx
              {
                  $value = $left.value != $right.value;
              }
            | left=ariphExprEx LESSEQUAL right=ariphExprEx
              {
                  $value = $left.value <= $right.value;
              }
            | left=ariphExprEx GREQUAL right=ariphExprEx
              {
                  $value = $left.value >= $right.value;
              }
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
                VarData data = metTable[currentMet].varTable[$ID.text];
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
declare : INTKEY ID
          {
           VarData newVar = new VarData
           {
                type = VarType.Int,
                value = 0
           };
           metTable[currentMet].varTable.Add($ID.text, newVar);
           Debug("Create var " + $ID.text);
          }
          (ASSIGN ariphExprEx)?
          {
           if ($ariphExprEx.text != null)
           {
                try
                {
                  VarData data = metTable[currentMet].varTable[$ID.text];
                  if (data.value.GetType() == $ariphExprEx.value.GetType()){
                    data.value = $ariphExprEx.value;
                   	Debug("\tAssigning1 it value of " + $ariphExprEx.text + $" = {data.value}"); 
                  }else
                    Error("Can't convert \"" + $ariphExprEx.text + "\" to Int");
                }
                catch (KeyNotFoundException)
                {
                  Error("Variable " + $ID.text + " does not exist in current context");
                }
           }
          }
          
        | DOUBLEKEY ID
          {
           VarData newVar = new VarData
           {
                type = VarType.Double,
                value = 0.0
           };
           metTable[currentMet].varTable.Add($ID.text, newVar);
           Debug("Create var " + $ID.text);
          }
          (ASSIGN ariphExprEx)?
          {
           if ($ariphExprEx.text != null)
           {
                Debug("\tAssigning2 it value of " + $ariphExprEx.text);
                try
                {
                  VarData data = metTable[currentMet].varTable[$ID.text];
                  if (data.value.GetType() == $ariphExprEx.value.GetType())
                    data.value = $ariphExprEx.value;
                  else if (data.type == VarType.Double)
                    data.value = (double)$ariphExprEx.value;
                }
                catch (KeyNotFoundException)
                {
                  Error("Variable " + $ID.text + " does not exist in current context");
                }
           }
          }
        | BOOLKEY ID
          {
           VarData newVar = new VarData
           {
                type = VarType.Bool,
                value = false
           };
           metTable[currentMet].varTable.Add($ID.text, newVar);
           Debug("Create var " + $ID.text);
          }
          (ASSIGN boolExprEx)?
          {
           if ($boolExprEx.text != null)
           {
                Debug("\tAssigning3 it value of " + $boolExprEx.text);
                try
                {
                  metTable[currentMet].varTable[$ID.text].value = $boolExprEx.value;
                }
                catch (KeyNotFoundException)
                {
                  Error("Variable " + $ID.text + " does not exist in cyrrent context");
                }
           }
          };

//trigonometry
sin returns [double value]:
		SIN LPAREN ariphExprEx RPAREN
		{
			$value = Math.Sin($ariphExprEx.value);
		};
cos returns [double value]:
		COS LPAREN ariphExprEx RPAREN
		{
			$value = Math.Cos($ariphExprEx.value);
		};
tan returns [double value]:
		TAN LPAREN ariphExprEx RPAREN
		{
			$value = Math.Tan($ariphExprEx.value);
		};
asin returns [double value]:
		ASIN LPAREN ariphExprEx RPAREN
		{
			$value = Math.Asin($ariphExprEx.value);
		};
acos returns [double value]:
		ACOS LPAREN ariphExprEx RPAREN
		{
			$value = Math.Acos($ariphExprEx.value);
		};
atan returns [double value]:
		ATAN LPAREN ariphExprEx RPAREN
		{
			$value = Math.Atan($ariphExprEx.value);
		};
atan2 returns [double value]:
		ATAN2 LPAREN y=ariphExprEx COMMA x=ariphExprEx RPAREN
		{
			$value = Math.Atan2($y.value, $x.value);
		};
		

//code related to cycles
myif: IF LPAREN boolExprEx RPAREN // вместо INT  нужен BOOL
     OBRACE 
    (operation)+
    CBRACE
     ELSE 
      OBRACE  
    (operation)+
    CBRACE
   ;
myif_short: IF LPAREN boolExprEx  RPAREN // вместо INT  нужен BOOL
    OBRACE
    (operation)+
    CBRACE
   ;
mywhile: WHILE LPAREN boolExprEx RPAREN // вместо INT  нужен BOOL
     OBRACE
     (operation)+
     CBRACE 
       ;
mydo_while: DO 
          OBRACE
            (operation)+
          CBRACE
          WHILE LPAREN boolExprEx RPAREN // вместо INT  нужен BOOL
          ;
myfor:  FOR LPAREN ~SEMICOLON+ SEMICOLON boolExprEx SEMICOLON ~SEMICOLON+ RPAREN // ~SEMICOLON+ заменяется на INT BOOL оператор
        OBRACE
        (operation)+
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
ASSIGN  : '=' ;
ADD     : '+' ;
SUB     : '-' ;
MUL     : '*' ;
DIV     : '/' ;
ADDASSIGN   : '+=' ;
SUBASSIGN   : '-=' ;
MULASSIGN   : '*=' ;
DIVASSIGN   : '/=' ;
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