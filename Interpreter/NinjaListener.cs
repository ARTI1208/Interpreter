//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     ANTLR Version: 4.7.2
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

// Generated from Ninja.g4 by ANTLR 4.7.2

// Unreachable code detected
#pragma warning disable 0162
// The variable '...' is assigned but its value is never used
#pragma warning disable 0219
// Missing XML comment for publicly visible type or member '...'
#pragma warning disable 1591
// Ambiguous reference in cref attribute
#pragma warning disable 419

using Antlr4.Runtime.Misc;
using IParseTreeListener = Antlr4.Runtime.Tree.IParseTreeListener;
using IToken = Antlr4.Runtime.IToken;

/// <summary>
/// This interface defines a complete listener for a parse tree produced by
/// <see cref="NinjaParser"/>.
/// </summary>
[System.CodeDom.Compiler.GeneratedCode("ANTLR", "4.7.2")]
[System.CLSCompliant(false)]
public interface INinjaListener : IParseTreeListener {
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.program"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterProgram([NotNull] NinjaParser.ProgramContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.program"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitProgram([NotNull] NinjaParser.ProgramContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.fun"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterFun([NotNull] NinjaParser.FunContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.fun"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitFun([NotNull] NinjaParser.FunContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.signature"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterSignature([NotNull] NinjaParser.SignatureContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.signature"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitSignature([NotNull] NinjaParser.SignatureContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.code"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterCode([NotNull] NinjaParser.CodeContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.code"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitCode([NotNull] NinjaParser.CodeContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.params"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterParams([NotNull] NinjaParser.ParamsContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.params"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitParams([NotNull] NinjaParser.ParamsContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.param"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterParam([NotNull] NinjaParser.ParamContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.param"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitParam([NotNull] NinjaParser.ParamContext context);
}
