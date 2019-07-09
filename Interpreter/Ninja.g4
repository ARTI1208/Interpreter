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
        public VarType type;
        public dynamic value;
        public string name;
    }

    public class MethodData
    {
        public string name;
		public bool isMeaningful;
        public ReturnType returnType;
        public ArrayList<NinjaParser.ParamData> paramList = new ArrayList<NinjaParser.ParamData>();
        public List<CallData> callList = new ArrayList<CallData>();
        
		public dynamic returnValue;
        
        public override string ToString()
        {
        	return $"fun {returnType} {name}, params : {paramList} ";
        }
        public Dictionary<string, VarData> varTable = new Dictionary<string, VarData>();
    }
 
    public static Dictionary<string, MethodData> metTable = new Dictionary<string, MethodData>();
    
    public bool CheckParams(NinjaParser.CallData call, NinjaParser.MethodData method)
    		{
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
    				}
    				else
    				{
    					Console.WriteLine($"Type mismatch: expected {method.paramList[i].type}, found {call.paramList[i].type} with value {call.paramList[i].value}");
    					return false;
    				}
    			}
    
    			return true;
    		}
    		
    		int depth = 0;
    		
    		public void GoThroughCalls(NinjaParser.MethodData methodData)
            		{
            			string formatter = new string('\t', depth);
            			Console.WriteLine($"{formatter}--Entering method {methodData.name}, params {ParamListToString(methodData.paramList)}:");
            			foreach (var call in methodData.callList)
            			{
            				if (call.callType == NinjaParser.CallType.Custom)
            				{
            					if (NinjaParser.metTable.ContainsKey(call.name))
            					{
            						++depth;
            						GoThroughCalls(NinjaParser.metTable[call.name]);
            					}
            				}
            				else
            				{
            					Console.WriteLine($"{formatter}Calling builtin method {call.name} with params {ParamListToString(call.paramList)}");
            //					Console.WriteLine(call.name);
            					switch (call.name)
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

main_signature : FUN_KEYWORD VOID MAIN OBRACKET CBRACKET {
	MethodData newMet = new MethodData
	{
		name = "main",
		returnType = ReturnType.Void
	};
	metTable.Add("main", newMet);
};

function : v_function | m_function ;

v_function: v_fun_signature OBRACE code CBRACE;

v_fun_signature : FUN_KEYWORD VOID WORD OBRACKET params CBRACKET {

	string methodName = $WORD.text;
	if (methodName == "main" || metTable.ContainsKey(methodName))
		throw new NotImplementedException("!!!Method overloading is not supported yet!!!");

	MethodData newMet = new MethodData
	{
		name = methodName,
		returnType = ReturnType.Void
	};
	
	foreach (var sig in _localctx.@params().var_signature())
    {
    	var d = new NinjaParser.ParamData()
    	{
    		name = sig.WORD().Symbol.Text
    	};
    	switch (sig.MEANINGFUL_TYPE().Symbol.Text)
    	{
    		case "int":
    			d.type = NinjaParser.VarType.Int;
    			break;
    		case "double":
    			d.type = NinjaParser.VarType.Double;
    			break;
    		case "bool":
    			d.type = NinjaParser.VarType.Bool;
    			break;
    		default:
    			throw new NotImplementedException();
    	}
    				
    	newMet.paramList.Add(d);
    			
    }
	metTable.Add(newMet.name, newMet);
};

m_function : m_fun_signature OBRACE code method_return CBRACE {

	string methodName = _localctx.m_fun_signature().WORD().Symbol.Text;
	
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

m_fun_signature: FUN_KEYWORD MEANINGFUL_TYPE WORD OBRACKET params CBRACKET {
	string methodName = $WORD.text;
	if (methodName == "main" || metTable.ContainsKey(methodName))
		throw new NotImplementedException("!!!Method overloading is not supported yet!!!");

	MethodData newMet = new MethodData
	{
		name = methodName,
		isMeaningful = true
	};
	
	switch($MEANINGFUL_TYPE.text)
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
    
	foreach (var sig in _localctx.@params().var_signature())
    {
    	var d = new NinjaParser.ParamData()
    	{
    		name = sig.WORD().Symbol.Text
    	};
    	switch (sig.MEANINGFUL_TYPE().Symbol.Text)
    	{
    		case "int":
    			d.type = NinjaParser.VarType.Int;
    			break;
    		case "double":
    			d.type = NinjaParser.VarType.Double;
    			break;
    		case "bool":
    			d.type = NinjaParser.VarType.Bool;
    			break;
    		default:
    			throw new NotImplementedException();
    	}
    				
    	newMet.paramList.Add(d);
    			
    }

	metTable.Add(newMet.name, newMet);
};

code : (call | custom_call)*;

main_code : (call | custom_call)*;

method_return returns [string type, dynamic value]: RETURN_KEYWORD val_or_id {
	$type = $val_or_id.type;
	$value = $val_or_id.value;
};

RETURN_KEYWORD : 'return';

MAIN : 'main' ;

FUN_KEYWORD : 'fun' ;

MEANINGFUL_TYPE : ('int'|'double'|'bool') ;

params : (var_signature (COMMA var_signature)*)? ;

var_signature : MEANINGFUL_TYPE WORD;

VOID : 'void' ;

COMMA : ',' ;

OBRACE : '{' ;
CBRACE : '}' ;

OBRACKET : '(' ;
CBRACKET : ')' ;

WS : [ \t\r\n]+ -> skip ;
COMMENT : '//'.*?[\n] -> skip ;

BOOL : ('true'|'false') ;
DOUBLE : [+-]?DIGIT*[.]DIGIT+ ;
INT : [+-]?DIGIT+ ;
fragment DIGIT : [0-9] ;

WORD : [a-zA-Z]+ ;

STRING : '"'[a-zA-Z]*'"' ;

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
		value = _localctx._parameterized_call.DOUBLE().GetText()
	};
    d.paramType = ParamType.Pass;				
    data.paramList.Add(d);
	
	string methodName = "";
	if (_localctx.Parent.Parent is V_functionContext parentContext)
	{
		methodName = parentContext.v_fun_signature().WORD().Symbol.Text;
	}		
	if (_localctx.Parent.Parent is M_functionContext parContext)
	{
		methodName = parContext.m_fun_signature().WORD().Symbol.Text;
	}
	if (_localctx.Parent.Parent is MainContext)
	{
		methodName = "main";
	}	

	if(methodName != ""){
		metTable[methodName].callList.Add(data);
	}

} | simple_call {

	CallData data = new CallData(){
		callType = CallType.BuiltIn, 
		name = $simple_call.text.Substring(0, $simple_call.text.IndexOf("(")),
		returnType = ReturnType.Void
	};

	string methodName = "";
	if (_localctx.Parent.Parent is V_functionContext parentContext)
	{
		methodName = parentContext.v_fun_signature().WORD().Symbol.Text;
	}		
	if (_localctx.Parent.Parent is M_functionContext parContext)
	{
		methodName = parContext.m_fun_signature().WORD().Symbol.Text;
	}
	if (_localctx.Parent.Parent is MainContext)
	{
		methodName = "main";
	}	

	if(methodName != ""){
		metTable[methodName].callList.Add(data);
	}
};

parameterized_call : builtin_func_p OBRACKET DOUBLE CBRACKET ;

simple_call : builtin_func_e OBRACKET CBRACKET;

custom_call : WORD OBRACKET call_params CBRACKET {

	string callName = $WORD.text;

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
	
	string methodName = "";
    if (_localctx.Parent.Parent is V_functionContext parentContext)
    {
    	methodName = parentContext.v_fun_signature().WORD().Symbol.Text;
    }		
    if (_localctx.Parent.Parent is M_functionContext parContext)
   	{
   		methodName = parContext.m_fun_signature().WORD().Symbol.Text;
   	}
   	if (_localctx.Parent.Parent is MainContext)
   	{
    	methodName = "main";
    }	
    Console.WriteLine($"call of {callName} in {methodName}, isKnownMet {metTable.ContainsKey(methodName)}");
    Console.WriteLine($"Params pass result {CheckParams(data, metTable[callName])}");
    
    
    if(methodName != ""){
    	metTable[methodName].callList.Add(data);
    }

};

call_params : (val_or_id (COMMA val_or_id)*)?;

val_or_id returns [string type, dynamic value]: (INT{

	$type = "int";
	$value = int.Parse($INT.text);

}|DOUBLE{
        
    $type = "double";
    try {
     	$value = double.Parse($DOUBLE.text);
    } catch {
        $value = double.Parse($DOUBLE.text.Replace('.', ','));
    }
        
}|BOOL{
      
   	$type = "bool";
    if($BOOL.text == "true")
    	$value = true;
    else
      	$value = false;
      
}|WORD{
      
    $type = "other";
    $value = $WORD.text;
    
}) ;