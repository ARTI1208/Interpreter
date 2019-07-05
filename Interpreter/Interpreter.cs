using System;
using System.IO;
using System.Text;
using Antlr4.Runtime;
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

		private static void Initialize()
		{
			try
			{
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