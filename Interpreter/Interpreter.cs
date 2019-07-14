using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Text;
using System.Threading;
using Antlr4.Runtime;
using Antlr4.Runtime.Misc;
using Antlr4.Runtime.Tree;

namespace Interpreter
{
	
	public class RealInterpreter
	{
		NinjaParser parser;
		public Queue<Command> commands = new Queue<Command>();
    
		public void Init(int id, string name)
		{
			var input = File.ReadAllText(name);
			var ms = new MemoryStream(Encoding.UTF8.GetBytes(input));
			var lexer = new NinjaLexer(new AntlrInputStream(ms));
			var tokens = new CommonTokenStream(lexer);
			parser = new NinjaParser(tokens);
			parser.owner = this;
			parser.id = id;
			var tree = parser.program();
		}
    
		public void Run()
		{
			if (parser != null)
				parser.metTable["main"].Eval();
		}

		public void UpdateInfo(string s)
		{
			if (parser != null)
				Main.Deserialize(s, ref parser.health, ref parser.xPos, ref parser.yPos, ref parser.dirs);
		}
	}
	
	public class Main
	{
		public static ManualResetEvent[] mre = new ManualResetEvent[4];
		static StreamWriter sw = new StreamWriter("log.txt");
		public static bool isInGui = false;
		
		public static void Log(string value)
		{
			sw.WriteLine("[" + DateTime.Now + "] " + value);
			sw.Flush();
		}
		
		public static void Deserialize(string s, ref int[] health, ref double[] xPos, ref double[] yPos, ref double[] dirs)
		{
			string[] vals = s.Replace('.', ',').Split(' ');
			for (int i = 0; i < 4; ++i)
			{
				health[i] = int.Parse(vals[i * 4]);
				xPos[i] = double.Parse(vals[i * 4 + 1]);
				yPos[i] = double.Parse(vals[i * 4 + 2]);
				dirs[i] = double.Parse(vals[i * 4 + 3]);
			}
		}
	}

	public class Command
	{
		public int type;
		public double param;

		public Command(int t = 0, double p = 0)
		{
			type = t;
			param = p;
		}
	}
	
	
	
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

				bool b = false;

				b |= true;
				b |= true;

				Console.WriteLine(b);
				
				var input = File.ReadAllText("..\\..\\..\\ProgramExamples\\nnj.npr");
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
				int t = 6;

				t = 5;
				Console.WriteLine(t.GetType());
			}
			catch (StackOverflowException e)
			{
				Console.WriteLine(e.Message);
			}


			initialized = true;
		}
	}
}