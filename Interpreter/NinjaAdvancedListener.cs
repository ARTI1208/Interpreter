using System;
using Antlr4.Runtime;
using Antlr4.Runtime.Tree;

namespace Interpreter
{
	public class NinjaAdvancedListener : INinjaListener
	{
		public void VisitTerminal(ITerminalNode node)
		{
			Console.WriteLine("terminal node");
			Console.WriteLine(node.Symbol);
		}

		public void VisitErrorNode(IErrorNode node)
		{
			Console.WriteLine("error node");
			Console.WriteLine(node.Symbol);
		}

		public void EnterEveryRule(ParserRuleContext ctx)
		{
			Console.WriteLine("enter rule");
			Console.WriteLine(ctx.ToString());
		}

		public void ExitEveryRule(ParserRuleContext ctx)
		{
			Console.WriteLine("exit rule");
			Console.WriteLine(ctx.ToString());
		}
		
		public void EnterProgram(NinjaParser.ProgramContext context)
		{
			Console.WriteLine("ent pr");
			Console.WriteLine(context.ToString());
		}

		public void ExitProgram(NinjaParser.ProgramContext context)
		{
			Console.WriteLine("ext pr");
			Console.WriteLine(context.ToString());
		}

		public void EnterFun(NinjaParser.FunContext context)
		{
			Console.WriteLine("ent fun");
			Console.WriteLine(context.ToString());
		}

		public void ExitFun(NinjaParser.FunContext context)
		{
			Console.WriteLine("ext fun");
			Console.WriteLine(context.ToString());
		}

		public void EnterSignature(NinjaParser.SignatureContext context)
		{
			Console.WriteLine("ent sig");
			Console.WriteLine(context.ToString());
		}

		public void ExitSignature(NinjaParser.SignatureContext context)
		{
			Console.WriteLine("ext sig");
			Console.WriteLine(context.ToString());
		}

		public void EnterCode(NinjaParser.CodeContext context)
		{
			Console.WriteLine("ent code");
			Console.WriteLine(context.ToString());
		}

		public void ExitCode(NinjaParser.CodeContext context)
		{
			Console.WriteLine("ext code");
			Console.WriteLine(context.ToString());
		}

		public void EnterParams(NinjaParser.ParamsContext context)
		{
			Console.WriteLine("ent params");
			Console.WriteLine(context.ToString());
		}

		public void ExitParams(NinjaParser.ParamsContext context)
		{
			Console.WriteLine("ext params");
			Console.WriteLine(context.ToString());
		}

		public void EnterParam(NinjaParser.ParamContext context)
		{
			Console.WriteLine("ent para");
			Console.WriteLine(context.ToString());
		}

		public void ExitParam(NinjaParser.ParamContext context)
		{
			Console.WriteLine("ext para");
			Console.WriteLine(context.ToString());
		}
	}
}