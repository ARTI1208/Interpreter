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

	public class ParamList
	{
		private ArrayList<NinjaParser.ParamData> _list = new ArrayList<NinjaParser.ParamData>();

		public void Add(NinjaParser.ParamData data)
		{
			Console.WriteLine(data);
			_list.Add(data);
		}
			
		public override string ToString()
		{
			if (_list.Count == 0)
			{
				return "<no params>";
			}

			string s = "{";
			foreach (var data in _list)
			{
				s += $" {data.type} {data.name},";
			}

			s = s.Substring(0, s.Length - 1) + " }";
			return s;
		}
	}
	
	public enum CallType
	{
		BuiltIn, Custom
	};
	
	public class CallData
	{
		public string name;
            
		public dynamic value;
            
		public CallType callType;
    	
		public ReturnType returnType;
    		
		public ParamList paramList = new ParamList();	
    	
    	public override string ToString()
        {
			return $"call {name} of type {callType} returns {returnType}, params : {paramList}";
		}
	}

	public enum VarType
	{
		Int, Double, Bool
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
	
	public enum ReturnType
	{
		Int, Double, Bool, Void
	};

    public class MethodData
    {
        public string name;
		public bool isMeaningful;
        public ReturnType returnType;
        public ParamList paramList = new ParamList();
        public List<CallData> callList = new ArrayList<CallData>();
        
		public dynamic returnValue;
        
        public override string ToString()
        {
        	return $"fun {returnType} {name}, params : {paramList} ";
        }
    }
 
    public static Dictionary<string, MethodData> metTable = new Dictionary<string, MethodData>();
}

program : function* main function*;

main locals[List<String> symbols = new ArrayList<String>()]: main_signature OBRACE main_code CBRACE;

main_signature : FUN_KEYWORD VOID MAIN OBRACKET CBRACKET {
MethodData newMet = new MethodData
	{
		name = "main",
		returnType = ReturnType.Void
	};
	metTable.Add("main", newMet);
	Console.WriteLine("Create MAIN met");
};

function locals[List<String> symbols = new ArrayList<String>()]: v_function
 {
 	
 }
 | m_function ;

v_function: v_fun_signature OBRACE code CBRACE {

try
{

	Console.WriteLine($v_fun_signature.text);

} catch {}





};

v_fun_signature : FUN_KEYWORD VOID WORD OBRACKET params CBRACKET {

string methodName = $WORD.text;
Console.WriteLine($"Creating {methodName}");
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
    			Console.WriteLine(newMet);
	metTable.Add(newMet.name, newMet);
	Console.WriteLine("Create met " + newMet.name);
};

m_function : m_fun_signature OBRACE code method_return CBRACE {
string methodName = _localctx.m_fun_signature().WORD().Symbol.Text;
Console.WriteLine($"Creating {methodName}");
if (methodName == "main" || metTable.ContainsKey(methodName))
	throw new NotImplementedException("!!!Method overloading is not supported yet!!!");


MethodData newMet = new MethodData
	{
		name = methodName
	};
	
	switch(_localctx.m_fun_signature().MEANINGFUL_TYPE().Symbol.Text)
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
				foreach (var sig in _localctx.m_fun_signature().@params().var_signature())
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
    			Console.WriteLine(newMet);
	metTable.Add(newMet.name, newMet);
	Console.WriteLine("Create met " + newMet.name);
};

m_fun_signature : FUN_KEYWORD MEANINGFUL_TYPE WORD OBRACKET params CBRACKET {
Console.WriteLine($"Creating m sig for {$WORD.text}");
};

code : ((CALL {
	CallData data = new CallData(){
		callType = CallType.BuiltIn, 
		name = $CALL.text.Substring(0, $CALL.text.IndexOf("(")),
		returnType = ReturnType.Void
	};

string methodName = "";
if (_localctx.Parent is V_functionContext parentContext)
			{
				methodName = parentContext.v_fun_signature().WORD().Symbol.Text;
			}
			
			if (_localctx.Parent is M_functionContext parContext)
			{
				methodName = parContext.m_fun_signature().WORD().Symbol.Text;
			}

if(methodName != ""){
Console.WriteLine(methodName);
	metTable[methodName].callList.Add(data);
	}
} | CUSTOM_CALL {
CallData data = new CallData(){
		callType = CallType.Custom, 
		name = $CALL.text.Substring(0, $CALL.text.IndexOf("(")),
		returnType = ReturnType.Void
	};

string methodName = "";
if (_localctx.Parent is V_functionContext parentContext)
			{
				methodName = parentContext.v_fun_signature().WORD().Symbol.Text;
			}
			
			if (_localctx.Parent is M_functionContext parContext)
			{
				methodName = parContext.m_fun_signature().WORD().Symbol.Text;
			}

if(methodName != ""){
Console.WriteLine(methodName);
	metTable[methodName].callList.Add(data);
	}

}))*;

main_code : (CALL {
	CallData data = new CallData(){
		callType = CallType.BuiltIn, 
		name = $CALL.text.Substring(0, $CALL.text.IndexOf("(")),
		returnType = ReturnType.Void
	};


	metTable["main"].callList.Add(data);
} | CUSTOM_CALL {
CallData data = new CallData(){
		callType = CallType.Custom, 
		name = $CUSTOM_CALL.text.Substring(0, $CUSTOM_CALL.text.IndexOf("(")),
		returnType = ReturnType.Void
	};

	metTable["main"].callList.Add(data);
})*;

method_return : RETURN_KEYWORD WORD ;

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

BUILTIN_FUNC : ('hit'|'move'|'turn'|'shoot') ;

CALL : BUILTIN_FUNC OBRACKET (INT|DOUBLE|BOOL|WORD) CBRACKET ;

CUSTOM_CALL : WORD OBRACKET (INT|DOUBLE|BOOL|WORD) CBRACKET ;