using System;
using System.Diagnostics;
using System.IO;
using System.Text;
using Antlr4.Runtime;
using Antlr4.Runtime.Misc;
using Antlr4.Runtime.Tree;

namespace Interpreter
{
	public class Interpreter
	{
		private static bool initialized;

		public static string getNextCommand()
		{
			if (!initialized) Initialize();

			return "tt";
		}

		public static void Main(string[] args)
		{
			Console.WriteLine(getNextCommand());
			Console.ReadKey();
		}
		
//		public class ParamList
//		{
//			private ArrayList<NinjaParser.ParamData> _list = new ArrayList<NinjaParser.ParamData>();
//
//			public void Add(NinjaParser.ParamData data)
//			{
//				_list.Add(data);
//			}
//			
//			public override string ToString()
//			{
//				if (_list.Count == 0)
//				{
//					return "<no params>";
//				}
//
//				string s = "{";
//				foreach (var data in _list)
//				{
//					s += $"{data.type} ,";
//				}
//
//				s = s.Substring(0, s.Length - 1) + "}";
//				return s;
//			}
//		}	

		private static void Initialize()
		{
			try
			{
				
				Process proc = new Process
				{
					StartInfo =
					{
						FileName = "CMD.exe",
						Arguments = @"/c ..\..\..\Interpreter\antlr.bat ..\..\..\Interpreter\Ninja.g4",
						WindowStyle = ProcessWindowStyle.Hidden
					}
				};
				proc.Start();
				proc.WaitForExit();
				
				
				var input = File.ReadAllText("..\\..\\nnj.npr");
				var ms = new MemoryStream(Encoding.UTF8.GetBytes(input));
				var lexer = new NinjaLexer(new AntlrInputStream(ms));
				var tokens = new CommonTokenStream(lexer);

				//  tokens.Fill();

				/*  foreach(var tok in tokens.GetTokens())
				  {
				      Console.WriteLine(tok);
				  }*/
				var parser = new NinjaParser(tokens);
				var tree = parser.program();

				var pastwk = new ParseTreeWalker();
				pastwk.Walk(new NinjaAdvancedListener(), tree);
			}
			catch (Exception e)
			{
				Console.WriteLine(e.Message);
			}


			initialized = true;
		}
	}
}