//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     ANTLR Version: 4.7.2
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

// Generated from ..\..\..\Interpreter\Ninja.g4 by ANTLR 4.7.2

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
	/// Enter a parse tree produced by <see cref="NinjaParser.main"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterMain([NotNull] NinjaParser.MainContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.main"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitMain([NotNull] NinjaParser.MainContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.main_signature"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterMain_signature([NotNull] NinjaParser.Main_signatureContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.main_signature"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitMain_signature([NotNull] NinjaParser.Main_signatureContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.function"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterFunction([NotNull] NinjaParser.FunctionContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.function"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitFunction([NotNull] NinjaParser.FunctionContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.v_function"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterV_function([NotNull] NinjaParser.V_functionContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.v_function"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitV_function([NotNull] NinjaParser.V_functionContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.v_fun_signature"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterV_fun_signature([NotNull] NinjaParser.V_fun_signatureContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.v_fun_signature"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitV_fun_signature([NotNull] NinjaParser.V_fun_signatureContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.m_function"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterM_function([NotNull] NinjaParser.M_functionContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.m_function"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitM_function([NotNull] NinjaParser.M_functionContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.m_fun_signature"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterM_fun_signature([NotNull] NinjaParser.M_fun_signatureContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.m_fun_signature"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitM_fun_signature([NotNull] NinjaParser.M_fun_signatureContext context);
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
	/// Enter a parse tree produced by <see cref="NinjaParser.main_code"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterMain_code([NotNull] NinjaParser.Main_codeContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.main_code"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitMain_code([NotNull] NinjaParser.Main_codeContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.operation"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterOperation([NotNull] NinjaParser.OperationContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.operation"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitOperation([NotNull] NinjaParser.OperationContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.method_return"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterMethod_return([NotNull] NinjaParser.Method_returnContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.method_return"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitMethod_return([NotNull] NinjaParser.Method_returnContext context);
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
	/// Enter a parse tree produced by <see cref="NinjaParser.var_signature"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterVar_signature([NotNull] NinjaParser.Var_signatureContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.var_signature"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitVar_signature([NotNull] NinjaParser.Var_signatureContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.builtin_func_p"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterBuiltin_func_p([NotNull] NinjaParser.Builtin_func_pContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.builtin_func_p"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitBuiltin_func_p([NotNull] NinjaParser.Builtin_func_pContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.builtin_func_e"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterBuiltin_func_e([NotNull] NinjaParser.Builtin_func_eContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.builtin_func_e"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitBuiltin_func_e([NotNull] NinjaParser.Builtin_func_eContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.call"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterCall([NotNull] NinjaParser.CallContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.call"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitCall([NotNull] NinjaParser.CallContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.parameterized_call"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterParameterized_call([NotNull] NinjaParser.Parameterized_callContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.parameterized_call"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitParameterized_call([NotNull] NinjaParser.Parameterized_callContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.simple_call"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterSimple_call([NotNull] NinjaParser.Simple_callContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.simple_call"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitSimple_call([NotNull] NinjaParser.Simple_callContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.custom_call"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterCustom_call([NotNull] NinjaParser.Custom_callContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.custom_call"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitCustom_call([NotNull] NinjaParser.Custom_callContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.call_params"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterCall_params([NotNull] NinjaParser.Call_paramsContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.call_params"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitCall_params([NotNull] NinjaParser.Call_paramsContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.val_or_id"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterVal_or_id([NotNull] NinjaParser.Val_or_idContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.val_or_id"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitVal_or_id([NotNull] NinjaParser.Val_or_idContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.ariphOperand"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterAriphOperand([NotNull] NinjaParser.AriphOperandContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.ariphOperand"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitAriphOperand([NotNull] NinjaParser.AriphOperandContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.ariphTerm"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterAriphTerm([NotNull] NinjaParser.AriphTermContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.ariphTerm"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitAriphTerm([NotNull] NinjaParser.AriphTermContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.ariphExpr"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterAriphExpr([NotNull] NinjaParser.AriphExprContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.ariphExpr"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitAriphExpr([NotNull] NinjaParser.AriphExprContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.ariphExprEx"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterAriphExprEx([NotNull] NinjaParser.AriphExprExContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.ariphExprEx"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitAriphExprEx([NotNull] NinjaParser.AriphExprExContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.boolOperand"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterBoolOperand([NotNull] NinjaParser.BoolOperandContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.boolOperand"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitBoolOperand([NotNull] NinjaParser.BoolOperandContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.boolExpr"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterBoolExpr([NotNull] NinjaParser.BoolExprContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.boolExpr"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitBoolExpr([NotNull] NinjaParser.BoolExprContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.boolExprEx"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterBoolExprEx([NotNull] NinjaParser.BoolExprExContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.boolExprEx"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitBoolExprEx([NotNull] NinjaParser.BoolExprExContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.declare"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterDeclare([NotNull] NinjaParser.DeclareContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.declare"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitDeclare([NotNull] NinjaParser.DeclareContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.sin"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterSin([NotNull] NinjaParser.SinContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.sin"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitSin([NotNull] NinjaParser.SinContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.cos"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterCos([NotNull] NinjaParser.CosContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.cos"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitCos([NotNull] NinjaParser.CosContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.tan"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterTan([NotNull] NinjaParser.TanContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.tan"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitTan([NotNull] NinjaParser.TanContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.asin"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterAsin([NotNull] NinjaParser.AsinContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.asin"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitAsin([NotNull] NinjaParser.AsinContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.acos"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterAcos([NotNull] NinjaParser.AcosContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.acos"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitAcos([NotNull] NinjaParser.AcosContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.atan"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterAtan([NotNull] NinjaParser.AtanContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.atan"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitAtan([NotNull] NinjaParser.AtanContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.atan2"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterAtan2([NotNull] NinjaParser.Atan2Context context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.atan2"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitAtan2([NotNull] NinjaParser.Atan2Context context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.myif"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterMyif([NotNull] NinjaParser.MyifContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.myif"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitMyif([NotNull] NinjaParser.MyifContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.myif_short"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterMyif_short([NotNull] NinjaParser.Myif_shortContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.myif_short"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitMyif_short([NotNull] NinjaParser.Myif_shortContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.mywhile"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterMywhile([NotNull] NinjaParser.MywhileContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.mywhile"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitMywhile([NotNull] NinjaParser.MywhileContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.mydo_while"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterMydo_while([NotNull] NinjaParser.Mydo_whileContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.mydo_while"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitMydo_while([NotNull] NinjaParser.Mydo_whileContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.myfor"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterMyfor([NotNull] NinjaParser.MyforContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.myfor"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitMyfor([NotNull] NinjaParser.MyforContext context);
	/// <summary>
	/// Enter a parse tree produced by <see cref="NinjaParser.meaningfulType"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void EnterMeaningfulType([NotNull] NinjaParser.MeaningfulTypeContext context);
	/// <summary>
	/// Exit a parse tree produced by <see cref="NinjaParser.meaningfulType"/>.
	/// </summary>
	/// <param name="context">The parse tree.</param>
	void ExitMeaningfulType([NotNull] NinjaParser.MeaningfulTypeContext context);
}
