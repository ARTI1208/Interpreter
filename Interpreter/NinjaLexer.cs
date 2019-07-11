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

using System;
using System.IO;
using System.Text;
using Antlr4.Runtime;
using Antlr4.Runtime.Atn;
using Antlr4.Runtime.Misc;
using DFA = Antlr4.Runtime.Dfa.DFA;

[System.CodeDom.Compiler.GeneratedCode("ANTLR", "4.7.2")]
[System.CLSCompliant(false)]
public partial class NinjaLexer : Lexer {
	protected static DFA[] decisionToDFA;
	protected static PredictionContextCache sharedContextCache = new PredictionContextCache();
	public const int
		T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, T__6=7, T__7=8, T__8=9, 
		SEMICOLON=10, INTKEY=11, DOUBLEKEY=12, BOOLKEY=13, WHILE=14, FOR=15, DO=16, 
		IF=17, ELSE=18, SIN=19, COS=20, TAN=21, ASIN=22, ACOS=23, ATAN=24, ATAN2=25, 
		ADD=26, SUB=27, MUL=28, DIV=29, INC=30, DEC=31, ASSIGN=32, ADDASSIGN=33, 
		SUBASSIGN=34, MULASSIGN=35, DIVASSIGN=36, AND=37, OR=38, NOT=39, LESS=40, 
		GREATER=41, EQUAL=42, NOTEQUAL=43, LESSEQUAL=44, GREQUAL=45, WS=46, BOOL=47, 
		DOUBLE=48, INT=49, RETURN_KEYWORD=50, PASS=51, MAIN=52, FUN_KEYWORD=53, 
		VOID=54, COMMA=55, OBRACE=56, CBRACE=57, LPAREN=58, RPAREN=59, COMMENT=60, 
		STRING=61, ID=62;
	public static string[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static string[] modeNames = {
		"DEFAULT_MODE"
	};

	public static readonly string[] ruleNames = {
		"T__0", "T__1", "T__2", "T__3", "T__4", "T__5", "T__6", "T__7", "T__8", 
		"SEMICOLON", "INTKEY", "DOUBLEKEY", "BOOLKEY", "WHILE", "FOR", "DO", "IF", 
		"ELSE", "SIN", "COS", "TAN", "ASIN", "ACOS", "ATAN", "ATAN2", "ADD", "SUB", 
		"MUL", "DIV", "INC", "DEC", "ASSIGN", "ADDASSIGN", "SUBASSIGN", "MULASSIGN", 
		"DIVASSIGN", "AND", "OR", "NOT", "LESS", "GREATER", "EQUAL", "NOTEQUAL", 
		"LESSEQUAL", "GREQUAL", "WS", "BOOL", "DOUBLE", "INT", "RETURN_KEYWORD", 
		"PASS", "MAIN", "FUN_KEYWORD", "VOID", "COMMA", "OBRACE", "CBRACE", "LPAREN", 
		"RPAREN", "COMMENT", "STRING", "ID", "LETTER", "DIGIT"
	};


	public NinjaLexer(ICharStream input)
	: this(input, Console.Out, Console.Error) { }

	public NinjaLexer(ICharStream input, TextWriter output, TextWriter errorOutput)
	: base(input, output, errorOutput)
	{
		Interpreter = new LexerATNSimulator(this, _ATN, decisionToDFA, sharedContextCache);
	}

	private static readonly string[] _LiteralNames = {
		null, "'getSelfId'", "'getPositionX'", "'getPositionY'", "'getDirection'", 
		"'getHealth'", "'move'", "'turn'", "'hit'", "'shoot'", "';'", "'int'", 
		"'double'", "'bool'", "'while'", "'for'", "'do'", "'if'", "'else'", "'sin'", 
		"'cos'", "'tan'", "'asin'", "'acos'", "'atan'", "'atan2'", "'+'", "'-'", 
		"'*'", "'/'", "'++'", "'--'", "'='", "'+='", "'-='", "'*='", "'/='", "'&&'", 
		"'||'", "'!'", "'<'", "'>'", "'=='", "'!='", "'<='", "'>='", null, null, 
		null, null, "'return'", "'pass'", "'main'", "'fun'", "'void'", "','", 
		"'{'", "'}'", "'('", "')'"
	};
	private static readonly string[] _SymbolicNames = {
		null, null, null, null, null, null, null, null, null, null, "SEMICOLON", 
		"INTKEY", "DOUBLEKEY", "BOOLKEY", "WHILE", "FOR", "DO", "IF", "ELSE", 
		"SIN", "COS", "TAN", "ASIN", "ACOS", "ATAN", "ATAN2", "ADD", "SUB", "MUL", 
		"DIV", "INC", "DEC", "ASSIGN", "ADDASSIGN", "SUBASSIGN", "MULASSIGN", 
		"DIVASSIGN", "AND", "OR", "NOT", "LESS", "GREATER", "EQUAL", "NOTEQUAL", 
		"LESSEQUAL", "GREQUAL", "WS", "BOOL", "DOUBLE", "INT", "RETURN_KEYWORD", 
		"PASS", "MAIN", "FUN_KEYWORD", "VOID", "COMMA", "OBRACE", "CBRACE", "LPAREN", 
		"RPAREN", "COMMENT", "STRING", "ID"
	};
	public static readonly IVocabulary DefaultVocabulary = new Vocabulary(_LiteralNames, _SymbolicNames);

	[NotNull]
	public override IVocabulary Vocabulary
	{
		get
		{
			return DefaultVocabulary;
		}
	}

	public override string GrammarFileName { get { return "Ninja.g4"; } }

	public override string[] RuleNames { get { return ruleNames; } }

	public override string[] ChannelNames { get { return channelNames; } }

	public override string[] ModeNames { get { return modeNames; } }

	public override string SerializedAtn { get { return new string(_serializedATN); } }

	static NinjaLexer() {
		decisionToDFA = new DFA[_ATN.NumberOfDecisions];
		for (int i = 0; i < _ATN.NumberOfDecisions; i++) {
			decisionToDFA[i] = new DFA(_ATN.GetDecisionState(i), i);
		}
	}
	private static char[] _serializedATN = {
		'\x3', '\x608B', '\xA72A', '\x8133', '\xB9ED', '\x417C', '\x3BE7', '\x7786', 
		'\x5964', '\x2', '@', '\x1BD', '\b', '\x1', '\x4', '\x2', '\t', '\x2', 
		'\x4', '\x3', '\t', '\x3', '\x4', '\x4', '\t', '\x4', '\x4', '\x5', '\t', 
		'\x5', '\x4', '\x6', '\t', '\x6', '\x4', '\a', '\t', '\a', '\x4', '\b', 
		'\t', '\b', '\x4', '\t', '\t', '\t', '\x4', '\n', '\t', '\n', '\x4', '\v', 
		'\t', '\v', '\x4', '\f', '\t', '\f', '\x4', '\r', '\t', '\r', '\x4', '\xE', 
		'\t', '\xE', '\x4', '\xF', '\t', '\xF', '\x4', '\x10', '\t', '\x10', '\x4', 
		'\x11', '\t', '\x11', '\x4', '\x12', '\t', '\x12', '\x4', '\x13', '\t', 
		'\x13', '\x4', '\x14', '\t', '\x14', '\x4', '\x15', '\t', '\x15', '\x4', 
		'\x16', '\t', '\x16', '\x4', '\x17', '\t', '\x17', '\x4', '\x18', '\t', 
		'\x18', '\x4', '\x19', '\t', '\x19', '\x4', '\x1A', '\t', '\x1A', '\x4', 
		'\x1B', '\t', '\x1B', '\x4', '\x1C', '\t', '\x1C', '\x4', '\x1D', '\t', 
		'\x1D', '\x4', '\x1E', '\t', '\x1E', '\x4', '\x1F', '\t', '\x1F', '\x4', 
		' ', '\t', ' ', '\x4', '!', '\t', '!', '\x4', '\"', '\t', '\"', '\x4', 
		'#', '\t', '#', '\x4', '$', '\t', '$', '\x4', '%', '\t', '%', '\x4', '&', 
		'\t', '&', '\x4', '\'', '\t', '\'', '\x4', '(', '\t', '(', '\x4', ')', 
		'\t', ')', '\x4', '*', '\t', '*', '\x4', '+', '\t', '+', '\x4', ',', '\t', 
		',', '\x4', '-', '\t', '-', '\x4', '.', '\t', '.', '\x4', '/', '\t', '/', 
		'\x4', '\x30', '\t', '\x30', '\x4', '\x31', '\t', '\x31', '\x4', '\x32', 
		'\t', '\x32', '\x4', '\x33', '\t', '\x33', '\x4', '\x34', '\t', '\x34', 
		'\x4', '\x35', '\t', '\x35', '\x4', '\x36', '\t', '\x36', '\x4', '\x37', 
		'\t', '\x37', '\x4', '\x38', '\t', '\x38', '\x4', '\x39', '\t', '\x39', 
		'\x4', ':', '\t', ':', '\x4', ';', '\t', ';', '\x4', '<', '\t', '<', '\x4', 
		'=', '\t', '=', '\x4', '>', '\t', '>', '\x4', '?', '\t', '?', '\x4', '@', 
		'\t', '@', '\x4', '\x41', '\t', '\x41', '\x3', '\x2', '\x3', '\x2', '\x3', 
		'\x2', '\x3', '\x2', '\x3', '\x2', '\x3', '\x2', '\x3', '\x2', '\x3', 
		'\x2', '\x3', '\x2', '\x3', '\x2', '\x3', '\x3', '\x3', '\x3', '\x3', 
		'\x3', '\x3', '\x3', '\x3', '\x3', '\x3', '\x3', '\x3', '\x3', '\x3', 
		'\x3', '\x3', '\x3', '\x3', '\x3', '\x3', '\x3', '\x3', '\x3', '\x3', 
		'\x3', '\x3', '\x4', '\x3', '\x4', '\x3', '\x4', '\x3', '\x4', '\x3', 
		'\x4', '\x3', '\x4', '\x3', '\x4', '\x3', '\x4', '\x3', '\x4', '\x3', 
		'\x4', '\x3', '\x4', '\x3', '\x4', '\x3', '\x4', '\x3', '\x5', '\x3', 
		'\x5', '\x3', '\x5', '\x3', '\x5', '\x3', '\x5', '\x3', '\x5', '\x3', 
		'\x5', '\x3', '\x5', '\x3', '\x5', '\x3', '\x5', '\x3', '\x5', '\x3', 
		'\x5', '\x3', '\x5', '\x3', '\x6', '\x3', '\x6', '\x3', '\x6', '\x3', 
		'\x6', '\x3', '\x6', '\x3', '\x6', '\x3', '\x6', '\x3', '\x6', '\x3', 
		'\x6', '\x3', '\x6', '\x3', '\a', '\x3', '\a', '\x3', '\a', '\x3', '\a', 
		'\x3', '\a', '\x3', '\b', '\x3', '\b', '\x3', '\b', '\x3', '\b', '\x3', 
		'\b', '\x3', '\t', '\x3', '\t', '\x3', '\t', '\x3', '\t', '\x3', '\n', 
		'\x3', '\n', '\x3', '\n', '\x3', '\n', '\x3', '\n', '\x3', '\n', '\x3', 
		'\v', '\x3', '\v', '\x3', '\f', '\x3', '\f', '\x3', '\f', '\x3', '\f', 
		'\x3', '\r', '\x3', '\r', '\x3', '\r', '\x3', '\r', '\x3', '\r', '\x3', 
		'\r', '\x3', '\r', '\x3', '\xE', '\x3', '\xE', '\x3', '\xE', '\x3', '\xE', 
		'\x3', '\xE', '\x3', '\xF', '\x3', '\xF', '\x3', '\xF', '\x3', '\xF', 
		'\x3', '\xF', '\x3', '\xF', '\x3', '\x10', '\x3', '\x10', '\x3', '\x10', 
		'\x3', '\x10', '\x3', '\x11', '\x3', '\x11', '\x3', '\x11', '\x3', '\x12', 
		'\x3', '\x12', '\x3', '\x12', '\x3', '\x13', '\x3', '\x13', '\x3', '\x13', 
		'\x3', '\x13', '\x3', '\x13', '\x3', '\x14', '\x3', '\x14', '\x3', '\x14', 
		'\x3', '\x14', '\x3', '\x15', '\x3', '\x15', '\x3', '\x15', '\x3', '\x15', 
		'\x3', '\x16', '\x3', '\x16', '\x3', '\x16', '\x3', '\x16', '\x3', '\x17', 
		'\x3', '\x17', '\x3', '\x17', '\x3', '\x17', '\x3', '\x17', '\x3', '\x18', 
		'\x3', '\x18', '\x3', '\x18', '\x3', '\x18', '\x3', '\x18', '\x3', '\x19', 
		'\x3', '\x19', '\x3', '\x19', '\x3', '\x19', '\x3', '\x19', '\x3', '\x1A', 
		'\x3', '\x1A', '\x3', '\x1A', '\x3', '\x1A', '\x3', '\x1A', '\x3', '\x1A', 
		'\x3', '\x1B', '\x3', '\x1B', '\x3', '\x1C', '\x3', '\x1C', '\x3', '\x1D', 
		'\x3', '\x1D', '\x3', '\x1E', '\x3', '\x1E', '\x3', '\x1F', '\x3', '\x1F', 
		'\x3', '\x1F', '\x3', ' ', '\x3', ' ', '\x3', ' ', '\x3', '!', '\x3', 
		'!', '\x3', '\"', '\x3', '\"', '\x3', '\"', '\x3', '#', '\x3', '#', '\x3', 
		'#', '\x3', '$', '\x3', '$', '\x3', '$', '\x3', '%', '\x3', '%', '\x3', 
		'%', '\x3', '&', '\x3', '&', '\x3', '&', '\x3', '\'', '\x3', '\'', '\x3', 
		'\'', '\x3', '(', '\x3', '(', '\x3', ')', '\x3', ')', '\x3', '*', '\x3', 
		'*', '\x3', '+', '\x3', '+', '\x3', '+', '\x3', ',', '\x3', ',', '\x3', 
		',', '\x3', '-', '\x3', '-', '\x3', '-', '\x3', '.', '\x3', '.', '\x3', 
		'.', '\x3', '/', '\x6', '/', '\x150', '\n', '/', '\r', '/', '\xE', '/', 
		'\x151', '\x3', '/', '\x3', '/', '\x3', '\x30', '\x3', '\x30', '\x3', 
		'\x30', '\x3', '\x30', '\x3', '\x30', '\x3', '\x30', '\x3', '\x30', '\x3', 
		'\x30', '\x3', '\x30', '\x5', '\x30', '\x15F', '\n', '\x30', '\x3', '\x31', 
		'\x5', '\x31', '\x162', '\n', '\x31', '\x3', '\x31', '\a', '\x31', '\x165', 
		'\n', '\x31', '\f', '\x31', '\xE', '\x31', '\x168', '\v', '\x31', '\x3', 
		'\x31', '\x3', '\x31', '\x6', '\x31', '\x16C', '\n', '\x31', '\r', '\x31', 
		'\xE', '\x31', '\x16D', '\x3', '\x32', '\x5', '\x32', '\x171', '\n', '\x32', 
		'\x3', '\x32', '\x6', '\x32', '\x174', '\n', '\x32', '\r', '\x32', '\xE', 
		'\x32', '\x175', '\x3', '\x33', '\x3', '\x33', '\x3', '\x33', '\x3', '\x33', 
		'\x3', '\x33', '\x3', '\x33', '\x3', '\x33', '\x3', '\x34', '\x3', '\x34', 
		'\x3', '\x34', '\x3', '\x34', '\x3', '\x34', '\x3', '\x35', '\x3', '\x35', 
		'\x3', '\x35', '\x3', '\x35', '\x3', '\x35', '\x3', '\x36', '\x3', '\x36', 
		'\x3', '\x36', '\x3', '\x36', '\x3', '\x37', '\x3', '\x37', '\x3', '\x37', 
		'\x3', '\x37', '\x3', '\x37', '\x3', '\x38', '\x3', '\x38', '\x3', '\x39', 
		'\x3', '\x39', '\x3', ':', '\x3', ':', '\x3', ';', '\x3', ';', '\x3', 
		'<', '\x3', '<', '\x3', '=', '\x3', '=', '\x3', '=', '\x3', '=', '\a', 
		'=', '\x1A0', '\n', '=', '\f', '=', '\xE', '=', '\x1A3', '\v', '=', '\x3', 
		'=', '\x3', '=', '\x3', '=', '\x3', '=', '\x3', '>', '\x3', '>', '\a', 
		'>', '\x1AB', '\n', '>', '\f', '>', '\xE', '>', '\x1AE', '\v', '>', '\x3', 
		'>', '\x3', '>', '\x3', '?', '\x3', '?', '\x3', '?', '\a', '?', '\x1B5', 
		'\n', '?', '\f', '?', '\xE', '?', '\x1B8', '\v', '?', '\x3', '@', '\x3', 
		'@', '\x3', '\x41', '\x3', '\x41', '\x3', '\x1A1', '\x2', '\x42', '\x3', 
		'\x3', '\x5', '\x4', '\a', '\x5', '\t', '\x6', '\v', '\a', '\r', '\b', 
		'\xF', '\t', '\x11', '\n', '\x13', '\v', '\x15', '\f', '\x17', '\r', '\x19', 
		'\xE', '\x1B', '\xF', '\x1D', '\x10', '\x1F', '\x11', '!', '\x12', '#', 
		'\x13', '%', '\x14', '\'', '\x15', ')', '\x16', '+', '\x17', '-', '\x18', 
		'/', '\x19', '\x31', '\x1A', '\x33', '\x1B', '\x35', '\x1C', '\x37', '\x1D', 
		'\x39', '\x1E', ';', '\x1F', '=', ' ', '?', '!', '\x41', '\"', '\x43', 
		'#', '\x45', '$', 'G', '%', 'I', '&', 'K', '\'', 'M', '(', 'O', ')', 'Q', 
		'*', 'S', '+', 'U', ',', 'W', '-', 'Y', '.', '[', '/', ']', '\x30', '_', 
		'\x31', '\x61', '\x32', '\x63', '\x33', '\x65', '\x34', 'g', '\x35', 'i', 
		'\x36', 'k', '\x37', 'm', '\x38', 'o', '\x39', 'q', ':', 's', ';', 'u', 
		'<', 'w', '=', 'y', '>', '{', '?', '}', '@', '\x7F', '\x2', '\x81', '\x2', 
		'\x3', '\x2', '\t', '\x5', '\x2', '\v', '\f', '\xF', '\xF', '\"', '\"', 
		'\x4', '\x2', '-', '-', '/', '/', '\x3', '\x2', '\x30', '\x30', '\x3', 
		'\x2', '\f', '\f', '\x4', '\x2', '\x43', '\\', '\x63', '|', '\x5', '\x2', 
		'\x43', '\\', '\x61', '\x61', '\x63', '|', '\x3', '\x2', '\x32', ';', 
		'\x2', '\x1C5', '\x2', '\x3', '\x3', '\x2', '\x2', '\x2', '\x2', '\x5', 
		'\x3', '\x2', '\x2', '\x2', '\x2', '\a', '\x3', '\x2', '\x2', '\x2', '\x2', 
		'\t', '\x3', '\x2', '\x2', '\x2', '\x2', '\v', '\x3', '\x2', '\x2', '\x2', 
		'\x2', '\r', '\x3', '\x2', '\x2', '\x2', '\x2', '\xF', '\x3', '\x2', '\x2', 
		'\x2', '\x2', '\x11', '\x3', '\x2', '\x2', '\x2', '\x2', '\x13', '\x3', 
		'\x2', '\x2', '\x2', '\x2', '\x15', '\x3', '\x2', '\x2', '\x2', '\x2', 
		'\x17', '\x3', '\x2', '\x2', '\x2', '\x2', '\x19', '\x3', '\x2', '\x2', 
		'\x2', '\x2', '\x1B', '\x3', '\x2', '\x2', '\x2', '\x2', '\x1D', '\x3', 
		'\x2', '\x2', '\x2', '\x2', '\x1F', '\x3', '\x2', '\x2', '\x2', '\x2', 
		'!', '\x3', '\x2', '\x2', '\x2', '\x2', '#', '\x3', '\x2', '\x2', '\x2', 
		'\x2', '%', '\x3', '\x2', '\x2', '\x2', '\x2', '\'', '\x3', '\x2', '\x2', 
		'\x2', '\x2', ')', '\x3', '\x2', '\x2', '\x2', '\x2', '+', '\x3', '\x2', 
		'\x2', '\x2', '\x2', '-', '\x3', '\x2', '\x2', '\x2', '\x2', '/', '\x3', 
		'\x2', '\x2', '\x2', '\x2', '\x31', '\x3', '\x2', '\x2', '\x2', '\x2', 
		'\x33', '\x3', '\x2', '\x2', '\x2', '\x2', '\x35', '\x3', '\x2', '\x2', 
		'\x2', '\x2', '\x37', '\x3', '\x2', '\x2', '\x2', '\x2', '\x39', '\x3', 
		'\x2', '\x2', '\x2', '\x2', ';', '\x3', '\x2', '\x2', '\x2', '\x2', '=', 
		'\x3', '\x2', '\x2', '\x2', '\x2', '?', '\x3', '\x2', '\x2', '\x2', '\x2', 
		'\x41', '\x3', '\x2', '\x2', '\x2', '\x2', '\x43', '\x3', '\x2', '\x2', 
		'\x2', '\x2', '\x45', '\x3', '\x2', '\x2', '\x2', '\x2', 'G', '\x3', '\x2', 
		'\x2', '\x2', '\x2', 'I', '\x3', '\x2', '\x2', '\x2', '\x2', 'K', '\x3', 
		'\x2', '\x2', '\x2', '\x2', 'M', '\x3', '\x2', '\x2', '\x2', '\x2', 'O', 
		'\x3', '\x2', '\x2', '\x2', '\x2', 'Q', '\x3', '\x2', '\x2', '\x2', '\x2', 
		'S', '\x3', '\x2', '\x2', '\x2', '\x2', 'U', '\x3', '\x2', '\x2', '\x2', 
		'\x2', 'W', '\x3', '\x2', '\x2', '\x2', '\x2', 'Y', '\x3', '\x2', '\x2', 
		'\x2', '\x2', '[', '\x3', '\x2', '\x2', '\x2', '\x2', ']', '\x3', '\x2', 
		'\x2', '\x2', '\x2', '_', '\x3', '\x2', '\x2', '\x2', '\x2', '\x61', '\x3', 
		'\x2', '\x2', '\x2', '\x2', '\x63', '\x3', '\x2', '\x2', '\x2', '\x2', 
		'\x65', '\x3', '\x2', '\x2', '\x2', '\x2', 'g', '\x3', '\x2', '\x2', '\x2', 
		'\x2', 'i', '\x3', '\x2', '\x2', '\x2', '\x2', 'k', '\x3', '\x2', '\x2', 
		'\x2', '\x2', 'm', '\x3', '\x2', '\x2', '\x2', '\x2', 'o', '\x3', '\x2', 
		'\x2', '\x2', '\x2', 'q', '\x3', '\x2', '\x2', '\x2', '\x2', 's', '\x3', 
		'\x2', '\x2', '\x2', '\x2', 'u', '\x3', '\x2', '\x2', '\x2', '\x2', 'w', 
		'\x3', '\x2', '\x2', '\x2', '\x2', 'y', '\x3', '\x2', '\x2', '\x2', '\x2', 
		'{', '\x3', '\x2', '\x2', '\x2', '\x2', '}', '\x3', '\x2', '\x2', '\x2', 
		'\x3', '\x83', '\x3', '\x2', '\x2', '\x2', '\x5', '\x8D', '\x3', '\x2', 
		'\x2', '\x2', '\a', '\x9A', '\x3', '\x2', '\x2', '\x2', '\t', '\xA7', 
		'\x3', '\x2', '\x2', '\x2', '\v', '\xB4', '\x3', '\x2', '\x2', '\x2', 
		'\r', '\xBE', '\x3', '\x2', '\x2', '\x2', '\xF', '\xC3', '\x3', '\x2', 
		'\x2', '\x2', '\x11', '\xC8', '\x3', '\x2', '\x2', '\x2', '\x13', '\xCC', 
		'\x3', '\x2', '\x2', '\x2', '\x15', '\xD2', '\x3', '\x2', '\x2', '\x2', 
		'\x17', '\xD4', '\x3', '\x2', '\x2', '\x2', '\x19', '\xD8', '\x3', '\x2', 
		'\x2', '\x2', '\x1B', '\xDF', '\x3', '\x2', '\x2', '\x2', '\x1D', '\xE4', 
		'\x3', '\x2', '\x2', '\x2', '\x1F', '\xEA', '\x3', '\x2', '\x2', '\x2', 
		'!', '\xEE', '\x3', '\x2', '\x2', '\x2', '#', '\xF1', '\x3', '\x2', '\x2', 
		'\x2', '%', '\xF4', '\x3', '\x2', '\x2', '\x2', '\'', '\xF9', '\x3', '\x2', 
		'\x2', '\x2', ')', '\xFD', '\x3', '\x2', '\x2', '\x2', '+', '\x101', '\x3', 
		'\x2', '\x2', '\x2', '-', '\x105', '\x3', '\x2', '\x2', '\x2', '/', '\x10A', 
		'\x3', '\x2', '\x2', '\x2', '\x31', '\x10F', '\x3', '\x2', '\x2', '\x2', 
		'\x33', '\x114', '\x3', '\x2', '\x2', '\x2', '\x35', '\x11A', '\x3', '\x2', 
		'\x2', '\x2', '\x37', '\x11C', '\x3', '\x2', '\x2', '\x2', '\x39', '\x11E', 
		'\x3', '\x2', '\x2', '\x2', ';', '\x120', '\x3', '\x2', '\x2', '\x2', 
		'=', '\x122', '\x3', '\x2', '\x2', '\x2', '?', '\x125', '\x3', '\x2', 
		'\x2', '\x2', '\x41', '\x128', '\x3', '\x2', '\x2', '\x2', '\x43', '\x12A', 
		'\x3', '\x2', '\x2', '\x2', '\x45', '\x12D', '\x3', '\x2', '\x2', '\x2', 
		'G', '\x130', '\x3', '\x2', '\x2', '\x2', 'I', '\x133', '\x3', '\x2', 
		'\x2', '\x2', 'K', '\x136', '\x3', '\x2', '\x2', '\x2', 'M', '\x139', 
		'\x3', '\x2', '\x2', '\x2', 'O', '\x13C', '\x3', '\x2', '\x2', '\x2', 
		'Q', '\x13E', '\x3', '\x2', '\x2', '\x2', 'S', '\x140', '\x3', '\x2', 
		'\x2', '\x2', 'U', '\x142', '\x3', '\x2', '\x2', '\x2', 'W', '\x145', 
		'\x3', '\x2', '\x2', '\x2', 'Y', '\x148', '\x3', '\x2', '\x2', '\x2', 
		'[', '\x14B', '\x3', '\x2', '\x2', '\x2', ']', '\x14F', '\x3', '\x2', 
		'\x2', '\x2', '_', '\x15E', '\x3', '\x2', '\x2', '\x2', '\x61', '\x161', 
		'\x3', '\x2', '\x2', '\x2', '\x63', '\x170', '\x3', '\x2', '\x2', '\x2', 
		'\x65', '\x177', '\x3', '\x2', '\x2', '\x2', 'g', '\x17E', '\x3', '\x2', 
		'\x2', '\x2', 'i', '\x183', '\x3', '\x2', '\x2', '\x2', 'k', '\x188', 
		'\x3', '\x2', '\x2', '\x2', 'm', '\x18C', '\x3', '\x2', '\x2', '\x2', 
		'o', '\x191', '\x3', '\x2', '\x2', '\x2', 'q', '\x193', '\x3', '\x2', 
		'\x2', '\x2', 's', '\x195', '\x3', '\x2', '\x2', '\x2', 'u', '\x197', 
		'\x3', '\x2', '\x2', '\x2', 'w', '\x199', '\x3', '\x2', '\x2', '\x2', 
		'y', '\x19B', '\x3', '\x2', '\x2', '\x2', '{', '\x1A8', '\x3', '\x2', 
		'\x2', '\x2', '}', '\x1B1', '\x3', '\x2', '\x2', '\x2', '\x7F', '\x1B9', 
		'\x3', '\x2', '\x2', '\x2', '\x81', '\x1BB', '\x3', '\x2', '\x2', '\x2', 
		'\x83', '\x84', '\a', 'i', '\x2', '\x2', '\x84', '\x85', '\a', 'g', '\x2', 
		'\x2', '\x85', '\x86', '\a', 'v', '\x2', '\x2', '\x86', '\x87', '\a', 
		'U', '\x2', '\x2', '\x87', '\x88', '\a', 'g', '\x2', '\x2', '\x88', '\x89', 
		'\a', 'n', '\x2', '\x2', '\x89', '\x8A', '\a', 'h', '\x2', '\x2', '\x8A', 
		'\x8B', '\a', 'K', '\x2', '\x2', '\x8B', '\x8C', '\a', '\x66', '\x2', 
		'\x2', '\x8C', '\x4', '\x3', '\x2', '\x2', '\x2', '\x8D', '\x8E', '\a', 
		'i', '\x2', '\x2', '\x8E', '\x8F', '\a', 'g', '\x2', '\x2', '\x8F', '\x90', 
		'\a', 'v', '\x2', '\x2', '\x90', '\x91', '\a', 'R', '\x2', '\x2', '\x91', 
		'\x92', '\a', 'q', '\x2', '\x2', '\x92', '\x93', '\a', 'u', '\x2', '\x2', 
		'\x93', '\x94', '\a', 'k', '\x2', '\x2', '\x94', '\x95', '\a', 'v', '\x2', 
		'\x2', '\x95', '\x96', '\a', 'k', '\x2', '\x2', '\x96', '\x97', '\a', 
		'q', '\x2', '\x2', '\x97', '\x98', '\a', 'p', '\x2', '\x2', '\x98', '\x99', 
		'\a', 'Z', '\x2', '\x2', '\x99', '\x6', '\x3', '\x2', '\x2', '\x2', '\x9A', 
		'\x9B', '\a', 'i', '\x2', '\x2', '\x9B', '\x9C', '\a', 'g', '\x2', '\x2', 
		'\x9C', '\x9D', '\a', 'v', '\x2', '\x2', '\x9D', '\x9E', '\a', 'R', '\x2', 
		'\x2', '\x9E', '\x9F', '\a', 'q', '\x2', '\x2', '\x9F', '\xA0', '\a', 
		'u', '\x2', '\x2', '\xA0', '\xA1', '\a', 'k', '\x2', '\x2', '\xA1', '\xA2', 
		'\a', 'v', '\x2', '\x2', '\xA2', '\xA3', '\a', 'k', '\x2', '\x2', '\xA3', 
		'\xA4', '\a', 'q', '\x2', '\x2', '\xA4', '\xA5', '\a', 'p', '\x2', '\x2', 
		'\xA5', '\xA6', '\a', '[', '\x2', '\x2', '\xA6', '\b', '\x3', '\x2', '\x2', 
		'\x2', '\xA7', '\xA8', '\a', 'i', '\x2', '\x2', '\xA8', '\xA9', '\a', 
		'g', '\x2', '\x2', '\xA9', '\xAA', '\a', 'v', '\x2', '\x2', '\xAA', '\xAB', 
		'\a', '\x46', '\x2', '\x2', '\xAB', '\xAC', '\a', 'k', '\x2', '\x2', '\xAC', 
		'\xAD', '\a', 't', '\x2', '\x2', '\xAD', '\xAE', '\a', 'g', '\x2', '\x2', 
		'\xAE', '\xAF', '\a', '\x65', '\x2', '\x2', '\xAF', '\xB0', '\a', 'v', 
		'\x2', '\x2', '\xB0', '\xB1', '\a', 'k', '\x2', '\x2', '\xB1', '\xB2', 
		'\a', 'q', '\x2', '\x2', '\xB2', '\xB3', '\a', 'p', '\x2', '\x2', '\xB3', 
		'\n', '\x3', '\x2', '\x2', '\x2', '\xB4', '\xB5', '\a', 'i', '\x2', '\x2', 
		'\xB5', '\xB6', '\a', 'g', '\x2', '\x2', '\xB6', '\xB7', '\a', 'v', '\x2', 
		'\x2', '\xB7', '\xB8', '\a', 'J', '\x2', '\x2', '\xB8', '\xB9', '\a', 
		'g', '\x2', '\x2', '\xB9', '\xBA', '\a', '\x63', '\x2', '\x2', '\xBA', 
		'\xBB', '\a', 'n', '\x2', '\x2', '\xBB', '\xBC', '\a', 'v', '\x2', '\x2', 
		'\xBC', '\xBD', '\a', 'j', '\x2', '\x2', '\xBD', '\f', '\x3', '\x2', '\x2', 
		'\x2', '\xBE', '\xBF', '\a', 'o', '\x2', '\x2', '\xBF', '\xC0', '\a', 
		'q', '\x2', '\x2', '\xC0', '\xC1', '\a', 'x', '\x2', '\x2', '\xC1', '\xC2', 
		'\a', 'g', '\x2', '\x2', '\xC2', '\xE', '\x3', '\x2', '\x2', '\x2', '\xC3', 
		'\xC4', '\a', 'v', '\x2', '\x2', '\xC4', '\xC5', '\a', 'w', '\x2', '\x2', 
		'\xC5', '\xC6', '\a', 't', '\x2', '\x2', '\xC6', '\xC7', '\a', 'p', '\x2', 
		'\x2', '\xC7', '\x10', '\x3', '\x2', '\x2', '\x2', '\xC8', '\xC9', '\a', 
		'j', '\x2', '\x2', '\xC9', '\xCA', '\a', 'k', '\x2', '\x2', '\xCA', '\xCB', 
		'\a', 'v', '\x2', '\x2', '\xCB', '\x12', '\x3', '\x2', '\x2', '\x2', '\xCC', 
		'\xCD', '\a', 'u', '\x2', '\x2', '\xCD', '\xCE', '\a', 'j', '\x2', '\x2', 
		'\xCE', '\xCF', '\a', 'q', '\x2', '\x2', '\xCF', '\xD0', '\a', 'q', '\x2', 
		'\x2', '\xD0', '\xD1', '\a', 'v', '\x2', '\x2', '\xD1', '\x14', '\x3', 
		'\x2', '\x2', '\x2', '\xD2', '\xD3', '\a', '=', '\x2', '\x2', '\xD3', 
		'\x16', '\x3', '\x2', '\x2', '\x2', '\xD4', '\xD5', '\a', 'k', '\x2', 
		'\x2', '\xD5', '\xD6', '\a', 'p', '\x2', '\x2', '\xD6', '\xD7', '\a', 
		'v', '\x2', '\x2', '\xD7', '\x18', '\x3', '\x2', '\x2', '\x2', '\xD8', 
		'\xD9', '\a', '\x66', '\x2', '\x2', '\xD9', '\xDA', '\a', 'q', '\x2', 
		'\x2', '\xDA', '\xDB', '\a', 'w', '\x2', '\x2', '\xDB', '\xDC', '\a', 
		'\x64', '\x2', '\x2', '\xDC', '\xDD', '\a', 'n', '\x2', '\x2', '\xDD', 
		'\xDE', '\a', 'g', '\x2', '\x2', '\xDE', '\x1A', '\x3', '\x2', '\x2', 
		'\x2', '\xDF', '\xE0', '\a', '\x64', '\x2', '\x2', '\xE0', '\xE1', '\a', 
		'q', '\x2', '\x2', '\xE1', '\xE2', '\a', 'q', '\x2', '\x2', '\xE2', '\xE3', 
		'\a', 'n', '\x2', '\x2', '\xE3', '\x1C', '\x3', '\x2', '\x2', '\x2', '\xE4', 
		'\xE5', '\a', 'y', '\x2', '\x2', '\xE5', '\xE6', '\a', 'j', '\x2', '\x2', 
		'\xE6', '\xE7', '\a', 'k', '\x2', '\x2', '\xE7', '\xE8', '\a', 'n', '\x2', 
		'\x2', '\xE8', '\xE9', '\a', 'g', '\x2', '\x2', '\xE9', '\x1E', '\x3', 
		'\x2', '\x2', '\x2', '\xEA', '\xEB', '\a', 'h', '\x2', '\x2', '\xEB', 
		'\xEC', '\a', 'q', '\x2', '\x2', '\xEC', '\xED', '\a', 't', '\x2', '\x2', 
		'\xED', ' ', '\x3', '\x2', '\x2', '\x2', '\xEE', '\xEF', '\a', '\x66', 
		'\x2', '\x2', '\xEF', '\xF0', '\a', 'q', '\x2', '\x2', '\xF0', '\"', '\x3', 
		'\x2', '\x2', '\x2', '\xF1', '\xF2', '\a', 'k', '\x2', '\x2', '\xF2', 
		'\xF3', '\a', 'h', '\x2', '\x2', '\xF3', '$', '\x3', '\x2', '\x2', '\x2', 
		'\xF4', '\xF5', '\a', 'g', '\x2', '\x2', '\xF5', '\xF6', '\a', 'n', '\x2', 
		'\x2', '\xF6', '\xF7', '\a', 'u', '\x2', '\x2', '\xF7', '\xF8', '\a', 
		'g', '\x2', '\x2', '\xF8', '&', '\x3', '\x2', '\x2', '\x2', '\xF9', '\xFA', 
		'\a', 'u', '\x2', '\x2', '\xFA', '\xFB', '\a', 'k', '\x2', '\x2', '\xFB', 
		'\xFC', '\a', 'p', '\x2', '\x2', '\xFC', '(', '\x3', '\x2', '\x2', '\x2', 
		'\xFD', '\xFE', '\a', '\x65', '\x2', '\x2', '\xFE', '\xFF', '\a', 'q', 
		'\x2', '\x2', '\xFF', '\x100', '\a', 'u', '\x2', '\x2', '\x100', '*', 
		'\x3', '\x2', '\x2', '\x2', '\x101', '\x102', '\a', 'v', '\x2', '\x2', 
		'\x102', '\x103', '\a', '\x63', '\x2', '\x2', '\x103', '\x104', '\a', 
		'p', '\x2', '\x2', '\x104', ',', '\x3', '\x2', '\x2', '\x2', '\x105', 
		'\x106', '\a', '\x63', '\x2', '\x2', '\x106', '\x107', '\a', 'u', '\x2', 
		'\x2', '\x107', '\x108', '\a', 'k', '\x2', '\x2', '\x108', '\x109', '\a', 
		'p', '\x2', '\x2', '\x109', '.', '\x3', '\x2', '\x2', '\x2', '\x10A', 
		'\x10B', '\a', '\x63', '\x2', '\x2', '\x10B', '\x10C', '\a', '\x65', '\x2', 
		'\x2', '\x10C', '\x10D', '\a', 'q', '\x2', '\x2', '\x10D', '\x10E', '\a', 
		'u', '\x2', '\x2', '\x10E', '\x30', '\x3', '\x2', '\x2', '\x2', '\x10F', 
		'\x110', '\a', '\x63', '\x2', '\x2', '\x110', '\x111', '\a', 'v', '\x2', 
		'\x2', '\x111', '\x112', '\a', '\x63', '\x2', '\x2', '\x112', '\x113', 
		'\a', 'p', '\x2', '\x2', '\x113', '\x32', '\x3', '\x2', '\x2', '\x2', 
		'\x114', '\x115', '\a', '\x63', '\x2', '\x2', '\x115', '\x116', '\a', 
		'v', '\x2', '\x2', '\x116', '\x117', '\a', '\x63', '\x2', '\x2', '\x117', 
		'\x118', '\a', 'p', '\x2', '\x2', '\x118', '\x119', '\a', '\x34', '\x2', 
		'\x2', '\x119', '\x34', '\x3', '\x2', '\x2', '\x2', '\x11A', '\x11B', 
		'\a', '-', '\x2', '\x2', '\x11B', '\x36', '\x3', '\x2', '\x2', '\x2', 
		'\x11C', '\x11D', '\a', '/', '\x2', '\x2', '\x11D', '\x38', '\x3', '\x2', 
		'\x2', '\x2', '\x11E', '\x11F', '\a', ',', '\x2', '\x2', '\x11F', ':', 
		'\x3', '\x2', '\x2', '\x2', '\x120', '\x121', '\a', '\x31', '\x2', '\x2', 
		'\x121', '<', '\x3', '\x2', '\x2', '\x2', '\x122', '\x123', '\a', '-', 
		'\x2', '\x2', '\x123', '\x124', '\a', '-', '\x2', '\x2', '\x124', '>', 
		'\x3', '\x2', '\x2', '\x2', '\x125', '\x126', '\a', '/', '\x2', '\x2', 
		'\x126', '\x127', '\a', '/', '\x2', '\x2', '\x127', '@', '\x3', '\x2', 
		'\x2', '\x2', '\x128', '\x129', '\a', '?', '\x2', '\x2', '\x129', '\x42', 
		'\x3', '\x2', '\x2', '\x2', '\x12A', '\x12B', '\a', '-', '\x2', '\x2', 
		'\x12B', '\x12C', '\a', '?', '\x2', '\x2', '\x12C', '\x44', '\x3', '\x2', 
		'\x2', '\x2', '\x12D', '\x12E', '\a', '/', '\x2', '\x2', '\x12E', '\x12F', 
		'\a', '?', '\x2', '\x2', '\x12F', '\x46', '\x3', '\x2', '\x2', '\x2', 
		'\x130', '\x131', '\a', ',', '\x2', '\x2', '\x131', '\x132', '\a', '?', 
		'\x2', '\x2', '\x132', 'H', '\x3', '\x2', '\x2', '\x2', '\x133', '\x134', 
		'\a', '\x31', '\x2', '\x2', '\x134', '\x135', '\a', '?', '\x2', '\x2', 
		'\x135', 'J', '\x3', '\x2', '\x2', '\x2', '\x136', '\x137', '\a', '(', 
		'\x2', '\x2', '\x137', '\x138', '\a', '(', '\x2', '\x2', '\x138', 'L', 
		'\x3', '\x2', '\x2', '\x2', '\x139', '\x13A', '\a', '~', '\x2', '\x2', 
		'\x13A', '\x13B', '\a', '~', '\x2', '\x2', '\x13B', 'N', '\x3', '\x2', 
		'\x2', '\x2', '\x13C', '\x13D', '\a', '#', '\x2', '\x2', '\x13D', 'P', 
		'\x3', '\x2', '\x2', '\x2', '\x13E', '\x13F', '\a', '>', '\x2', '\x2', 
		'\x13F', 'R', '\x3', '\x2', '\x2', '\x2', '\x140', '\x141', '\a', '@', 
		'\x2', '\x2', '\x141', 'T', '\x3', '\x2', '\x2', '\x2', '\x142', '\x143', 
		'\a', '?', '\x2', '\x2', '\x143', '\x144', '\a', '?', '\x2', '\x2', '\x144', 
		'V', '\x3', '\x2', '\x2', '\x2', '\x145', '\x146', '\a', '#', '\x2', '\x2', 
		'\x146', '\x147', '\a', '?', '\x2', '\x2', '\x147', 'X', '\x3', '\x2', 
		'\x2', '\x2', '\x148', '\x149', '\a', '>', '\x2', '\x2', '\x149', '\x14A', 
		'\a', '?', '\x2', '\x2', '\x14A', 'Z', '\x3', '\x2', '\x2', '\x2', '\x14B', 
		'\x14C', '\a', '@', '\x2', '\x2', '\x14C', '\x14D', '\a', '?', '\x2', 
		'\x2', '\x14D', '\\', '\x3', '\x2', '\x2', '\x2', '\x14E', '\x150', '\t', 
		'\x2', '\x2', '\x2', '\x14F', '\x14E', '\x3', '\x2', '\x2', '\x2', '\x150', 
		'\x151', '\x3', '\x2', '\x2', '\x2', '\x151', '\x14F', '\x3', '\x2', '\x2', 
		'\x2', '\x151', '\x152', '\x3', '\x2', '\x2', '\x2', '\x152', '\x153', 
		'\x3', '\x2', '\x2', '\x2', '\x153', '\x154', '\b', '/', '\x2', '\x2', 
		'\x154', '^', '\x3', '\x2', '\x2', '\x2', '\x155', '\x156', '\a', 'v', 
		'\x2', '\x2', '\x156', '\x157', '\a', 't', '\x2', '\x2', '\x157', '\x158', 
		'\a', 'w', '\x2', '\x2', '\x158', '\x15F', '\a', 'g', '\x2', '\x2', '\x159', 
		'\x15A', '\a', 'h', '\x2', '\x2', '\x15A', '\x15B', '\a', '\x63', '\x2', 
		'\x2', '\x15B', '\x15C', '\a', 'n', '\x2', '\x2', '\x15C', '\x15D', '\a', 
		'u', '\x2', '\x2', '\x15D', '\x15F', '\a', 'g', '\x2', '\x2', '\x15E', 
		'\x155', '\x3', '\x2', '\x2', '\x2', '\x15E', '\x159', '\x3', '\x2', '\x2', 
		'\x2', '\x15F', '`', '\x3', '\x2', '\x2', '\x2', '\x160', '\x162', '\t', 
		'\x3', '\x2', '\x2', '\x161', '\x160', '\x3', '\x2', '\x2', '\x2', '\x161', 
		'\x162', '\x3', '\x2', '\x2', '\x2', '\x162', '\x166', '\x3', '\x2', '\x2', 
		'\x2', '\x163', '\x165', '\x5', '\x81', '\x41', '\x2', '\x164', '\x163', 
		'\x3', '\x2', '\x2', '\x2', '\x165', '\x168', '\x3', '\x2', '\x2', '\x2', 
		'\x166', '\x164', '\x3', '\x2', '\x2', '\x2', '\x166', '\x167', '\x3', 
		'\x2', '\x2', '\x2', '\x167', '\x169', '\x3', '\x2', '\x2', '\x2', '\x168', 
		'\x166', '\x3', '\x2', '\x2', '\x2', '\x169', '\x16B', '\t', '\x4', '\x2', 
		'\x2', '\x16A', '\x16C', '\x5', '\x81', '\x41', '\x2', '\x16B', '\x16A', 
		'\x3', '\x2', '\x2', '\x2', '\x16C', '\x16D', '\x3', '\x2', '\x2', '\x2', 
		'\x16D', '\x16B', '\x3', '\x2', '\x2', '\x2', '\x16D', '\x16E', '\x3', 
		'\x2', '\x2', '\x2', '\x16E', '\x62', '\x3', '\x2', '\x2', '\x2', '\x16F', 
		'\x171', '\t', '\x3', '\x2', '\x2', '\x170', '\x16F', '\x3', '\x2', '\x2', 
		'\x2', '\x170', '\x171', '\x3', '\x2', '\x2', '\x2', '\x171', '\x173', 
		'\x3', '\x2', '\x2', '\x2', '\x172', '\x174', '\x5', '\x81', '\x41', '\x2', 
		'\x173', '\x172', '\x3', '\x2', '\x2', '\x2', '\x174', '\x175', '\x3', 
		'\x2', '\x2', '\x2', '\x175', '\x173', '\x3', '\x2', '\x2', '\x2', '\x175', 
		'\x176', '\x3', '\x2', '\x2', '\x2', '\x176', '\x64', '\x3', '\x2', '\x2', 
		'\x2', '\x177', '\x178', '\a', 't', '\x2', '\x2', '\x178', '\x179', '\a', 
		'g', '\x2', '\x2', '\x179', '\x17A', '\a', 'v', '\x2', '\x2', '\x17A', 
		'\x17B', '\a', 'w', '\x2', '\x2', '\x17B', '\x17C', '\a', 't', '\x2', 
		'\x2', '\x17C', '\x17D', '\a', 'p', '\x2', '\x2', '\x17D', '\x66', '\x3', 
		'\x2', '\x2', '\x2', '\x17E', '\x17F', '\a', 'r', '\x2', '\x2', '\x17F', 
		'\x180', '\a', '\x63', '\x2', '\x2', '\x180', '\x181', '\a', 'u', '\x2', 
		'\x2', '\x181', '\x182', '\a', 'u', '\x2', '\x2', '\x182', 'h', '\x3', 
		'\x2', '\x2', '\x2', '\x183', '\x184', '\a', 'o', '\x2', '\x2', '\x184', 
		'\x185', '\a', '\x63', '\x2', '\x2', '\x185', '\x186', '\a', 'k', '\x2', 
		'\x2', '\x186', '\x187', '\a', 'p', '\x2', '\x2', '\x187', 'j', '\x3', 
		'\x2', '\x2', '\x2', '\x188', '\x189', '\a', 'h', '\x2', '\x2', '\x189', 
		'\x18A', '\a', 'w', '\x2', '\x2', '\x18A', '\x18B', '\a', 'p', '\x2', 
		'\x2', '\x18B', 'l', '\x3', '\x2', '\x2', '\x2', '\x18C', '\x18D', '\a', 
		'x', '\x2', '\x2', '\x18D', '\x18E', '\a', 'q', '\x2', '\x2', '\x18E', 
		'\x18F', '\a', 'k', '\x2', '\x2', '\x18F', '\x190', '\a', '\x66', '\x2', 
		'\x2', '\x190', 'n', '\x3', '\x2', '\x2', '\x2', '\x191', '\x192', '\a', 
		'.', '\x2', '\x2', '\x192', 'p', '\x3', '\x2', '\x2', '\x2', '\x193', 
		'\x194', '\a', '}', '\x2', '\x2', '\x194', 'r', '\x3', '\x2', '\x2', '\x2', 
		'\x195', '\x196', '\a', '\x7F', '\x2', '\x2', '\x196', 't', '\x3', '\x2', 
		'\x2', '\x2', '\x197', '\x198', '\a', '*', '\x2', '\x2', '\x198', 'v', 
		'\x3', '\x2', '\x2', '\x2', '\x199', '\x19A', '\a', '+', '\x2', '\x2', 
		'\x19A', 'x', '\x3', '\x2', '\x2', '\x2', '\x19B', '\x19C', '\a', '\x31', 
		'\x2', '\x2', '\x19C', '\x19D', '\a', '\x31', '\x2', '\x2', '\x19D', '\x1A1', 
		'\x3', '\x2', '\x2', '\x2', '\x19E', '\x1A0', '\v', '\x2', '\x2', '\x2', 
		'\x19F', '\x19E', '\x3', '\x2', '\x2', '\x2', '\x1A0', '\x1A3', '\x3', 
		'\x2', '\x2', '\x2', '\x1A1', '\x1A2', '\x3', '\x2', '\x2', '\x2', '\x1A1', 
		'\x19F', '\x3', '\x2', '\x2', '\x2', '\x1A2', '\x1A4', '\x3', '\x2', '\x2', 
		'\x2', '\x1A3', '\x1A1', '\x3', '\x2', '\x2', '\x2', '\x1A4', '\x1A5', 
		'\t', '\x5', '\x2', '\x2', '\x1A5', '\x1A6', '\x3', '\x2', '\x2', '\x2', 
		'\x1A6', '\x1A7', '\b', '=', '\x2', '\x2', '\x1A7', 'z', '\x3', '\x2', 
		'\x2', '\x2', '\x1A8', '\x1AC', '\a', '$', '\x2', '\x2', '\x1A9', '\x1AB', 
		'\t', '\x6', '\x2', '\x2', '\x1AA', '\x1A9', '\x3', '\x2', '\x2', '\x2', 
		'\x1AB', '\x1AE', '\x3', '\x2', '\x2', '\x2', '\x1AC', '\x1AA', '\x3', 
		'\x2', '\x2', '\x2', '\x1AC', '\x1AD', '\x3', '\x2', '\x2', '\x2', '\x1AD', 
		'\x1AF', '\x3', '\x2', '\x2', '\x2', '\x1AE', '\x1AC', '\x3', '\x2', '\x2', 
		'\x2', '\x1AF', '\x1B0', '\a', '$', '\x2', '\x2', '\x1B0', '|', '\x3', 
		'\x2', '\x2', '\x2', '\x1B1', '\x1B6', '\x5', '\x7F', '@', '\x2', '\x1B2', 
		'\x1B5', '\x5', '\x7F', '@', '\x2', '\x1B3', '\x1B5', '\x5', '\x81', '\x41', 
		'\x2', '\x1B4', '\x1B2', '\x3', '\x2', '\x2', '\x2', '\x1B4', '\x1B3', 
		'\x3', '\x2', '\x2', '\x2', '\x1B5', '\x1B8', '\x3', '\x2', '\x2', '\x2', 
		'\x1B6', '\x1B4', '\x3', '\x2', '\x2', '\x2', '\x1B6', '\x1B7', '\x3', 
		'\x2', '\x2', '\x2', '\x1B7', '~', '\x3', '\x2', '\x2', '\x2', '\x1B8', 
		'\x1B6', '\x3', '\x2', '\x2', '\x2', '\x1B9', '\x1BA', '\t', '\a', '\x2', 
		'\x2', '\x1BA', '\x80', '\x3', '\x2', '\x2', '\x2', '\x1BB', '\x1BC', 
		'\t', '\b', '\x2', '\x2', '\x1BC', '\x82', '\x3', '\x2', '\x2', '\x2', 
		'\xE', '\x2', '\x151', '\x15E', '\x161', '\x166', '\x16D', '\x170', '\x175', 
		'\x1A1', '\x1AC', '\x1B4', '\x1B6', '\x3', '\b', '\x2', '\x2',
	};

	public static readonly ATN _ATN =
		new ATNDeserializer().Deserialize(_serializedATN);


}
