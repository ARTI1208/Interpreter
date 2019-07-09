using System;
using System.IO;
using Antlr4.Runtime;
using Antlr4.Runtime.Misc;
using Antlr4.Runtime.Tree;

namespace Interpreter
{
	public class NinjaAdvancedListener : INinjaListener
	{
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

		public void VisitTerminal(ITerminalNode node)
		{
//			if (isCode)
//			{
//
//				switch (node.Symbol.Text.Substring(0, node.Symbol.Text.IndexOf("(")))
//				{
//					case "move":
//						Console.WriteLine($"move byte");
//						_bytes.Add(1);		
//						break;
//					case "turn" :
//						Console.WriteLine($"turn byte");
//						_bytes.Add(2);		
//						break;
//					default:
//						Console.WriteLine($"no byte for this op {node.Symbol.Text}");
//						break;
//				}
//				
//				
//			}
//			
//			Console.WriteLine("terminal node");
//			Console.WriteLine(node.Symbol);
		}

		public void VisitErrorNode(IErrorNode node)
		{
			Console.WriteLine("error node==================");
			Console.WriteLine(node.Symbol);
		}

		public void EnterEveryRule(ParserRuleContext ctx)
		{
//			Console.WriteLine("enter rule");
//			Console.WriteLine(ctx.ToString());
		}

		public void ExitEveryRule(ParserRuleContext ctx)
		{
//			Console.WriteLine("exit rule");
//			Console.WriteLine(ctx.ToString());
		}

		public void EnterProgram(NinjaParser.ProgramContext context)
		{
			Console.WriteLine("---------------------------------------------------Start");
//			Console.WriteLine("ent pr");
//			Console.WriteLine(context.ToString());
		}

		public bool CheckParams(NinjaParser.CallData call, NinjaParser.MethodData method)
		{
			if (call.paramList.Count != method.paramList.Count)
			{
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

		private int depth = 0;

		public void ExitProgram(NinjaParser.ProgramContext context)
		{
			Console.WriteLine("---------------------------------------------------End");

			GoThroughCalls(NinjaParser.metTable["main"]);
			File.Delete("cmds.txt");
			var stream = File.Create("cmds.txt");
			stream.WriteByte((byte) _bytes.Count);
			foreach (var b in _bytes)
			{
				stream.WriteByte(b);
			}

			stream.Close();
		}

		public void EnterMain(NinjaParser.MainContext context)
		{
			Console.WriteLine("ent main");
			Console.WriteLine(context.ToString());
		}

		public void GoThroughCalls(NinjaParser.MethodData methodData)
		{
			string formatter = new string('\t', depth);
			Console.WriteLine($"{formatter}--Entering method {methodData.name}, params {ParamListToString(methodData.paramList)}:");
			foreach (var call in methodData.callList)
			{
				if (call.callType == NinjaParser.CallType.Custom)
				{
					if (NinjaParser.metTable.ContainsKey(call.name) && CheckParams(call, NinjaParser.metTable[call.name]))
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

			--depth;
			Console.WriteLine($"{formatter}--Exiting method {methodData.name}");
		}

		public void ExitMain(NinjaParser.MainContext context)
		{
			Console.WriteLine("ext main");
			Console.WriteLine(context.ToString());
		}

		public void EnterMain_signature(NinjaParser.Main_signatureContext context)
		{
//			Console.WriteLine("ent main_sig");
//			Console.WriteLine(context.ToString());
		}

		public void ExitMain_signature(NinjaParser.Main_signatureContext context)
		{
//			Console.WriteLine("ext main_sig");
//			Console.WriteLine(context.ToString());
		}

		public void EnterFunction(NinjaParser.FunctionContext context)
		{
//			Console.WriteLine("ent fun");
//			Console.WriteLine(context.ToString());
		}

		public void ExitFunction(NinjaParser.FunctionContext context)
		{
//			Console.WriteLine("ext fun");
//			Console.WriteLine(context.ToString());
		}

		public void EnterV_function(NinjaParser.V_functionContext context)
		{
//			Console.WriteLine("ent v_fun");
//			Console.WriteLine(context.ToString());
		}

		public void ExitV_function(NinjaParser.V_functionContext context)
		{
//			Console.WriteLine("ext v_fun");
//			Console.WriteLine(context.ToString());
		}

		public void EnterV_fun_signature(NinjaParser.V_fun_signatureContext context)
		{
//			Console.WriteLine("ent v_fun_sig");
//			Console.WriteLine(data.ToString());
		}

		public void ExitV_fun_signature(NinjaParser.V_fun_signatureContext context)
		{
//			Console.WriteLine("ext v_fun_sig");
//			Console.WriteLine(context.ToString());
		}

		public void EnterM_function(NinjaParser.M_functionContext context)
		{
//			Console.WriteLine("ent m_fun");
//			Console.WriteLine(context.ToString());
		}

		public void ExitM_function(NinjaParser.M_functionContext context)
		{
//			Console.WriteLine("ext m_fun");
//			Console.WriteLine(context.ToString());
		}

		public void EnterM_fun_signature(NinjaParser.M_fun_signatureContext context)
		{
//			Console.WriteLine("ent m_fun_sig");
//			Console.WriteLine(context.ToString());
		}

		public void ExitM_fun_signature(NinjaParser.M_fun_signatureContext context)
		{
//			Console.WriteLine("ext m_fun_sig");
//			Console.WriteLine(context.ToString());
		}

		public void EnterCode(NinjaParser.CodeContext context)
		{
//			Console.WriteLine("ent code");
//			Console.WriteLine(context.ToString());
		}

		public void ExitCode(NinjaParser.CodeContext context)
		{
		}

		public void EnterMain_code(NinjaParser.Main_codeContext context)
		{
		}

		public void ExitMain_code(NinjaParser.Main_codeContext context)
		{
		}

		public void EnterMethod_return(NinjaParser.Method_returnContext context)
		{
		}

		public void ExitMethod_return(NinjaParser.Method_returnContext context)
		{
		}

		public void EnterParams(NinjaParser.ParamsContext context)
		{
		}

		public void ExitParams(NinjaParser.ParamsContext context)
		{
		}

		public void EnterVar_signature(NinjaParser.Var_signatureContext context)
		{
		}

		public void ExitVar_signature(NinjaParser.Var_signatureContext context)
		{
		}

		public void EnterBuiltin_func_p(NinjaParser.Builtin_func_pContext context)
		{
			
		}

		public void ExitBuiltin_func_p(NinjaParser.Builtin_func_pContext context)
		{
			
		}

		public void EnterBuiltin_func_e(NinjaParser.Builtin_func_eContext context)
		{
			
		}

		public void ExitBuiltin_func_e(NinjaParser.Builtin_func_eContext context)
		{
			
		}
		
		public void EnterCall(NinjaParser.CallContext context)
		{
			
		}

		public void ExitCall(NinjaParser.CallContext context)
		{
			
		}

		public void EnterParameterized_call(NinjaParser.Parameterized_callContext context)
		{
			
		}

		public void ExitParameterized_call(NinjaParser.Parameterized_callContext context)
		{
			
		}

		public void EnterSimple_call(NinjaParser.Simple_callContext context)
		{
			
		}

		public void ExitSimple_call(NinjaParser.Simple_callContext context)
		{
			
		}

		public void EnterCustom_call(NinjaParser.Custom_callContext context)
		{
			
		}

		public void ExitCustom_call(NinjaParser.Custom_callContext context)
		{
			
		}

		public void EnterCall_params(NinjaParser.Call_paramsContext context)
		{
			
		}

		public void ExitCall_params(NinjaParser.Call_paramsContext context)
		{
			
		}

		public void EnterCall_param(NinjaParser.Call_paramContext context)
		{
			
		}

		public void ExitCall_param(NinjaParser.Call_paramContext context)
		{
			
		}
	}
}