/*
 * TCLParser: P a r s e r  S u p p o r t
 *
 * Generated from: tcl.g
 *
 * Terence Parr, Russell Quong, Will Cohen, and Hank Dietz: 1989-2001
 * Parr Research Corporation
 * with Purdue University Electrical Engineering
 * with AHPCRC, University of Minnesota
 * ANTLR Version 1.33MR33
 */

#define ANTLR_VERSION	13333
#include "pcctscfg.h"
#include "pccts_stdio.h"
#define ANTLR_SUPPORT_CODE
#include "tokens.h"
#include "TCLParser.h"

const ANTLRChar *TCLParser::tokenName(int tok)   { return _token_tbl[tok]; }

const ANTLRChar *TCLParser::_token_tbl[]={
	/* 00 */	"Invalid",
	/* 01 */	"@",
	/* 02 */	"[\\ \\t]+",
	/* 03 */	"P_FOR",
	/* 04 */	"P_FOREACH",
	/* 05 */	"P_GLOBLAL",
	/* 06 */	"P_IF",
	/* 07 */	"P_ELSE",
	/* 08 */	"P_ELSEIF",
	/* 09 */	"P_LAPPEND",
	/* 10 */	"P_RETURN",
	/* 11 */	"P_SET",
	/* 12 */	"P_UNSET",
	/* 13 */	"P_WHILE",
	/* 14 */	"P_EXPR",
	/* 15 */	"P_LINSERT",
	/* 16 */	"P_LLENGTH",
	/* 17 */	"P_SWITCH",
	/* 18 */	"P_UPLEVEL",
	/* 19 */	"P_BINARY",
	/* 20 */	"P_BODY",
	/* 21 */	"P_CATCH",
	/* 22 */	"P_GETS",
	/* 23 */	"P_LSTAT",
	/* 24 */	"P_NAMESPACE",
	/* 25 */	"P_PARRAY",
	/* 26 */	"P_PROC",
	/* 27 */	"P_SOURCE",
	/* 28 */	"P_TKINFO",
	/* 29 */	"P_VARIABLE",
	/* 30 */	"P_CLASS",
	/* 31 */	"P_COMMON",
	/* 32 */	"P_CONFIGBODY",
	/* 33 */	"P_CONSTRUCTOR",
	/* 34 */	"P_DESTRUCTOR",
	/* 35 */	"P_INHERIT",
	/* 36 */	"P_ISA",
	/* 37 */	"P_ITCL_CLASS",
	/* 38 */	"P_ITK",
	/* 39 */	"P_IWIDGETS",
	/* 40 */	"P_LOCAL",
	/* 41 */	"P_METHOD",
	/* 42 */	"P_PRIVATE",
	/* 43 */	"P_PROTECTED",
	/* 44 */	"P_PUBLIC",
	/* 45 */	"P_VIRTUAL",
	/* 46 */	"P_NONEWLINE",
	/* 47 */	"P_THEN",
	/* 48 */	"P_PUTS",
	/* 49 */	"P_EQUALTO",
	/* 50 */	"P_EQUAL",
	/* 51 */	"P_GTHAN",
	/* 52 */	"P_GETHAN",
	/* 53 */	"P_LETHAN",
	/* 54 */	"P_LTHAN",
	/* 55 */	"P_NOTEQUALTO",
	/* 56 */	"P_AND",
	/* 57 */	"P_AND2",
	/* 58 */	"P_OR",
	/* 59 */	"P_NOT",
	/* 60 */	"P_MULT",
	/* 61 */	"P_ADD",
	/* 62 */	"P_DIV",
	/* 63 */	"P_SEMI",
	/* 64 */	"[^\\|,]",
	/* 65 */	"QUAL",
	/* 66 */	"\\@",
	/* 67 */	"?",
	/* 68 */	"\\-\\-",
	/* 69 */	"\\[\\ \\t]*\\n",
	/* 70 */	"NEW_LINE",
	/* 71 */	"\\%",
	/* 72 */	"'",
	/* 73 */	"IDENT5",
	/* 74 */	":",
	/* 75 */	"P_UPLEVEL_ABS",
	/* 76 */	"#",
	/* 77 */	"P_BIND",
	/* 78 */	"P_DOLLAR",
	/* 79 */	"\"",
	/* 80 */	"L_CURLY",
	/* 81 */	"R_CURLY",
	/* 82 */	"L_SQUARE",
	/* 83 */	"R_SQUARE",
	/* 84 */	"L_BRACKET",
	/* 85 */	"R_BRACKET",
	/* 86 */	"QUAL_IDENT",
	/* 87 */	"SOME_OTHER_IDENT",
	/* 88 */	"IDENT1",
	/* 89 */	"FILENAME",
	/* 90 */	"[0-9]+",
	/* 91 */	"\\-",
	/* 92 */	"IDENT3",
	/* 93 */	"P_DASHGLOB",
	/* 94 */	"P_FLOAT",
	/* 95 */	"P_INT",
	/* 96 */	"IDENT2",
	/* 97 */	"IDENT4",
	/* 98 */	"\\{",
	/* 99 */	"\\}",
	/* 100 */	"\\[\\ \\t]*\\n",
	/* 101 */	"\\n",
	/* 102 */	"~[]",
	/* 103 */	"[0-9]+",
	/* 104 */	"[a-zA-Z]",
	/* 105 */	"\\n",
	/* 106 */	"~[]",
	/* 107 */	"NUMBER",
	/* 108 */	"\\[\"\\$\\}\\{]",
	/* 109 */	"\\n",
	/* 110 */	"LIT_STRING",
	/* 111 */	"\\\\",
	/* 112 */	"~[]",
	/* 113 */	"P_OPERATORS",
	/* 114 */	"P_SUBTRACT",
	/* 115 */	"IDENT",
	/* 116 */	"LVALUE",
	/* 117 */	"ITCL30_CLASS_RESYNC",
	/* 118 */	"P_OPERATOR",
	/* 119 */	";",
	/* 120 */	"P_EVAL",
	/* 121 */	"BIND_EVENT",
	/* 122 */	"P_LIST",
	/* 123 */	"P_INFO",
	/* 124 */	"P_COMMENT"
};

TCLParser::TCLParser(ANTLRTokenBuffer *input) : ANTLRParser(input,1,1,0,16)
{
	token_tbl = _token_tbl;
	traceOptionValueDefault=0;		// MR10 turn trace OFF
}

SetWordType TCLParser::setwd1[125] = {0x0,0xa2,0x0,0xe9,0xe9,0xe9,0xe9,
	0xa0,0xa0,0xe9,0xe9,0xe9,0xe9,0xe9,0xe9,
	0xe9,0xe9,0xe9,0xe9,0x0,0xe9,0xe9,0xe9,
	0x0,0xe9,0x0,0xe9,0xe1,0x0,0xe9,0xed,
	0xa0,0x0,0xe9,0xe9,0xe9,0x0,0xe5,0x0,
	0x0,0xe9,0xe9,0xe9,0xe9,0xe9,0x0,0x0,
	0x0,0xe9,0xe9,0xe9,0xe9,0xe9,0xe9,0xe9,
	0xe9,0xe9,0xe9,0xe9,0xe9,0xe9,0xe9,0xe9,
	0xf9,0x0,0xe9,0x0,0x0,0x0,0x0,0xb0,
	0x0,0x0,0xe9,0x0,0xe9,0x0,0xe9,0xe9,
	0x0,0xa0,0xa0,0xe9,0xa0,0x80,0x0,0xe9,
	0xe9,0xe9,0x80,0x0,0x0,0xe9,0xe9,0x80,
	0x80,0xe9,0xe9,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x80,
	0x0,0x0,0x0,0xe9,0x0,0x0,0x0,0x80,
	0x80,0x0,0x0,0xe9,0x0,0xe9};
SetWordType TCLParser::IDENT_set[16] = {0x20,0xc,0x40,0x64, 0xe,0x1f,0xfe,0x7f, 0x0,0x22,0x80,0x21,
	0x3,0x0,0x4,0x0};
SetWordType TCLParser::IDENT_errset[16] = {0x20,0xc,0x40,0x64, 0xe,0x1f,0xfe,0x7f, 0x0,0x22,0x80,0x21,
	0x3,0x0,0x4,0x0};
SetWordType TCLParser::LVALUE_set[16] = {0x20,0xc,0x40,0x64, 0xe,0x1f,0xfe,0x7f, 0x0,0x22,0x80,0xe1,
	0x3,0x40,0x4,0x0};
SetWordType TCLParser::LVALUE_errset[16] = {0x20,0xc,0x40,0x64, 0xe,0x1f,0xfe,0x7f, 0x0,0x22,0x80,0xe1,
	0x3,0x40,0x4,0x0};
SetWordType TCLParser::setwd2[125] = {0x0,0x26,0x0,0x27,0x27,0xff,0x27,
	0x26,0x26,0x27,0xff,0xff,0x27,0x27,0x27,
	0x27,0x27,0x27,0x27,0x0,0x27,0x27,0xff,
	0x0,0x27,0x0,0xff,0x26,0x0,0xff,0xff,
	0x27,0x0,0xff,0xff,0xff,0x0,0x26,0x0,
	0x0,0xff,0xff,0xff,0xff,0xff,0x0,0x0,
	0x0,0x27,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0x27,0x0,0x27,0x0,0x0,0x0,0x0,0x27,
	0x0,0x0,0xff,0x0,0x27,0x0,0xff,0x27,
	0x0,0x2e,0x27,0x27,0x26,0x0,0x0,0x27,
	0xff,0xff,0x0,0x0,0x0,0x27,0xff,0x80,
	0x80,0xff,0xff,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x80,
	0x0,0x0,0x0,0xff,0x0,0x0,0x0,0x0,
	0x20,0x0,0x0,0x27,0x0,0x27};
SetWordType TCLParser::setwd3[125] = {0x0,0x8,0x0,0x0,0x0,0xf7,0x0,
	0x0,0x0,0x0,0xf7,0xf7,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0xf7,
	0x0,0x0,0x0,0xf7,0x0,0x0,0xf7,0xf7,
	0x0,0x0,0xf7,0xf7,0xf7,0x0,0x0,0x0,
	0x0,0xf7,0xf7,0xf7,0xf7,0xf7,0x0,0x0,
	0x0,0x0,0xf7,0xf7,0xf7,0xf7,0xf7,0xf7,
	0xf7,0xf7,0xf7,0xf7,0xf7,0xf7,0xf7,0xf7,
	0x0,0x0,0x80,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0xf7,0x0,0x0,0x0,0xf7,0x0,
	0x0,0x43,0x41,0x0,0x0,0x0,0x0,0x80,
	0xf7,0xf7,0x0,0x0,0x0,0x0,0xf7,0x20,
	0x20,0xf7,0xf7,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x20,
	0x0,0x0,0x0,0xf7,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0};
SetWordType TCLParser::setwd4[125] = {0x0,0x2c,0x0,0xbc,0xbc,0xbf,0xbc,
	0x2c,0x2c,0xbc,0xbf,0xbf,0xbc,0xbc,0xbc,
	0xbc,0xbc,0xbc,0xbc,0x0,0xbc,0xbc,0xbf,
	0x0,0xbc,0x0,0xbf,0x2c,0x0,0xbf,0xbf,
	0x3c,0x0,0xbf,0xbf,0xbf,0x0,0x2c,0x0,
	0x0,0xbf,0xbf,0xff,0xff,0xff,0x0,0x0,
	0x0,0xbc,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,
	0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,0xbf,
	0xbc,0x0,0xbf,0x0,0x0,0x0,0x0,0x2c,
	0x0,0x0,0xbf,0x0,0xbc,0x0,0xbf,0xbf,
	0x0,0x2f,0x2c,0xbf,0x2c,0x0,0x0,0xbf,
	0xbf,0xbf,0x3,0x0,0x0,0xbf,0xbf,0x3,
	0x3,0xbf,0xbf,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x3,
	0x0,0x0,0x0,0xbf,0x0,0x0,0x0,0x1,
	0x0,0x0,0x0,0xbc,0x0,0xbc};
SetWordType TCLParser::setwd5[125] = {0x0,0x4,0x0,0x5f,0x5f,0xff,0x5f,
	0x4,0x4,0x5f,0xff,0xff,0x5f,0x5f,0x5f,
	0x5f,0x5f,0x5f,0x5f,0x0,0x5f,0x5f,0xff,
	0x0,0x5f,0x0,0xff,0x4,0x0,0xff,0xff,
	0x57,0x0,0xff,0xff,0xff,0x0,0x4,0x0,
	0x0,0xff,0xff,0xff,0xff,0xff,0x0,0x0,
	0x0,0x5f,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0x5f,0x0,0x7f,0x0,0x0,0x0,0x0,0x44,
	0x0,0x0,0xff,0x0,0x5f,0x0,0xff,0x5f,
	0x0,0x84,0x55,0x5f,0x4,0x0,0x0,0x7f,
	0xff,0xff,0x0,0x0,0x0,0x5f,0xff,0x0,
	0x0,0xff,0xff,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0xff,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x5f,0x0,0x5f};
SetWordType TCLParser::setwd6[125] = {0x0,0x0,0x0,0x5e,0x5e,0xff,0x5e,
	0x0,0x0,0x5e,0xff,0xff,0x5e,0x5e,0x5e,
	0x5e,0x5e,0x5e,0x5e,0x0,0x5e,0x5e,0xff,
	0x0,0x5e,0x0,0xff,0x2,0x0,0xff,0xff,
	0x5c,0x0,0xff,0xff,0xff,0x0,0x2,0x0,
	0x0,0xff,0xff,0xff,0xff,0xff,0x0,0x0,
	0x0,0x5e,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0x5e,0x0,0xde,0x0,0x0,0x0,0x0,0x5c,
	0x0,0x0,0xff,0x0,0x5e,0x0,0xff,0xde,
	0x0,0xa0,0x5c,0xde,0x0,0x0,0x0,0xde,
	0xff,0xff,0x80,0x0,0x0,0xde,0xff,0x80,
	0x80,0xff,0xff,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x80,
	0x0,0x0,0x0,0xff,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x5e,0x0,0x5e};
SetWordType TCLParser::setwd7[125] = {0x0,0x0,0x0,0x75,0x75,0xff,0x75,
	0x0,0x0,0x75,0xff,0xff,0x75,0x75,0x75,
	0x75,0x75,0x75,0x75,0x0,0x75,0x75,0xff,
	0x0,0x75,0x0,0xff,0x0,0x0,0xff,0xff,
	0x75,0x0,0xff,0xff,0xff,0x0,0x0,0x0,
	0x0,0xff,0xff,0xff,0xff,0xff,0x0,0x0,
	0x0,0x75,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0x75,0x0,0xff,0x0,0x0,0x0,0x0,0x75,
	0x0,0x0,0xff,0x0,0x75,0x0,0xff,0xff,
	0x0,0x8a,0x75,0xff,0x0,0x0,0x0,0xff,
	0xff,0xff,0x8a,0x0,0x0,0xff,0xff,0x8a,
	0x8a,0xff,0xff,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x8a,
	0x0,0x0,0x0,0xff,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x75,0x0,0x75};
SetWordType TCLParser::NUMBER_set[16] = {0x0,0x0,0x0,0x0, 0x0,0x0,0x0,0x0, 0x0,0x0,0x0,0xc0
	};
SetWordType TCLParser::NUMBER_errset[16] = {0x0,0x0,0x0,0x0, 0x0,0x0,0x0,0x0, 0x0,0x0,0x0,0xc0
	};
SetWordType TCLParser::setwd8[125] = {0x0,0xe,0x0,0x26,0x26,0xb7,0x26,
	0x6,0x6,0x26,0xb7,0xb7,0x26,0x26,0x26,
	0x26,0x26,0x26,0x26,0x0,0x26,0x26,0xb7,
	0x0,0x26,0x0,0xb7,0x6,0x0,0xb7,0xb7,
	0x26,0x0,0xb7,0xb7,0xb7,0x0,0x6,0x0,
	0x0,0xb7,0xb7,0xb7,0xb7,0xb7,0x0,0x0,
	0x0,0x26,0xb7,0xb7,0xb7,0xb7,0xb7,0xb7,
	0xb7,0xb7,0xb7,0xb7,0xb7,0xb7,0xb7,0xb7,
	0x26,0x0,0x37,0x0,0x0,0x0,0x0,0x26,
	0x0,0x0,0xb7,0x0,0x26,0x0,0xb7,0x37,
	0x0,0x17,0x26,0x37,0x6,0x0,0x0,0xb7,
	0xb7,0xb7,0x11,0x0,0x0,0x37,0xb7,0x51,
	0x51,0xb7,0xb7,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x11,
	0x0,0x0,0x0,0xb7,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x26,0x0,0x26};
SetWordType TCLParser::setwd9[125] = {0x0,0x4a,0x0,0x7a,0x7a,0xff,0x7a,
	0x4a,0x4a,0x7a,0xff,0xff,0x7a,0x7a,0x7a,
	0x7a,0x7a,0x7a,0x7a,0x0,0x7a,0x7a,0xff,
	0x0,0x7a,0x0,0xff,0x7a,0x0,0xff,0xff,
	0x4a,0x0,0xff,0xff,0xff,0x0,0x7a,0x0,
	0x0,0xff,0xff,0xff,0xff,0xff,0x0,0x0,
	0x42,0x7a,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0x7a,0x0,0xfa,0x0,0x0,0x0,0x0,0x5a,
	0x0,0x0,0xff,0x0,0x7a,0x0,0xff,0x7b,
	0x0,0x4a,0x4a,0x7b,0x4a,0x42,0x42,0xfe,
	0xff,0xff,0x4a,0x0,0x0,0x7a,0xff,0x4b,
	0x4b,0xff,0xff,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x4b,
	0x0,0x0,0x0,0xff,0x0,0x0,0x0,0x42,
	0x42,0x0,0x42,0x7a,0x0,0x7a};
SetWordType TCLParser::setwd10[125] = {0x0,0xd1,0x0,0xd1,0xd1,0xff,0xd1,
	0xd1,0xd1,0xd1,0xff,0xff,0xd1,0xd1,0xd1,
	0xd1,0xd1,0xd1,0xd1,0x0,0xd1,0xd1,0xff,
	0x0,0xd1,0x0,0xff,0xd1,0x0,0xff,0xff,
	0xd1,0x0,0xff,0xff,0xff,0x0,0xd1,0x0,
	0x0,0xff,0xff,0xff,0xff,0xff,0x0,0x0,
	0xd1,0xd1,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xd1,0x0,0xf7,0x0,0x0,0x0,0x0,0xd1,
	0x0,0x0,0xff,0x0,0xd1,0x0,0xff,0xff,
	0x0,0xf7,0xd1,0xff,0xd1,0xdb,0xd1,0xf7,
	0xff,0xff,0xf7,0x0,0x0,0xf7,0xff,0xff,
	0xff,0xff,0xff,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0xff,
	0x0,0x0,0x0,0xff,0x0,0x0,0x0,0xd1,
	0xd1,0x0,0xd1,0xd1,0x0,0xd1};
SetWordType TCLParser::setwd11[125] = {0x0,0xd4,0x0,0xc4,0xc4,0xed,0xc4,
	0xc4,0xc4,0xc4,0xed,0xed,0xc4,0xc4,0xc4,
	0xc4,0xc4,0xc4,0xc6,0x0,0xc4,0xc4,0xed,
	0x0,0xc4,0x0,0xed,0xc4,0x0,0xed,0xed,
	0xc4,0x0,0xed,0xed,0xed,0x0,0xc4,0x0,
	0x0,0xed,0xed,0xed,0xed,0xed,0x0,0x0,
	0x0,0xc4,0xed,0xed,0xed,0xed,0xed,0xed,
	0xed,0xed,0xed,0xed,0xed,0xed,0xed,0xed,
	0xc4,0x0,0xed,0x0,0x0,0x0,0x0,0xc4,
	0x0,0x0,0xed,0x0,0xc6,0x0,0xed,0xed,
	0x0,0xec,0xc4,0xed,0xc4,0x0,0x0,0xed,
	0xed,0xed,0x28,0x0,0x0,0xed,0xed,0x28,
	0x28,0xed,0xed,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x28,
	0x0,0x0,0x0,0xed,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0xc4,0x0,0xc4};
SetWordType TCLParser::setwd12[125] = {0x0,0xa6,0x0,0xa6,0xa6,0xfe,0xa6,
	0xa6,0xa6,0xa6,0xfe,0xfe,0xa6,0xa6,0xa6,
	0xa6,0xa6,0xa6,0xa6,0x0,0xa6,0xa6,0xfe,
	0x0,0xa6,0x0,0xfe,0xa6,0x0,0xfe,0xfe,
	0xa6,0x0,0xfe,0xfe,0xfe,0x0,0xa6,0x0,
	0x0,0xfe,0xfe,0xfe,0xfe,0xfe,0x0,0x0,
	0x0,0xa6,0xfe,0xfe,0xfe,0xfe,0xfe,0xfe,
	0xfe,0xfe,0xfe,0xfe,0xfe,0xfe,0xff,0xfe,
	0xa6,0x0,0xfe,0x0,0x0,0x0,0x0,0xa6,
	0x0,0x0,0xfe,0x0,0xa6,0x0,0xfe,0xfe,
	0x0,0xb7,0xa6,0xfe,0xa6,0x0,0x0,0xfe,
	0xfe,0xfe,0x10,0x0,0x0,0xb6,0xfe,0x10,
	0x10,0xfe,0xfe,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x11,
	0x0,0x0,0x0,0xfe,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0xa6,0x0,0xa6};
SetWordType TCLParser::setwd13[125] = {0x0,0xd0,0x0,0x50,0x50,0x7d,0x50,
	0x50,0x50,0x50,0x7d,0x7d,0x50,0x50,0x50,
	0x50,0x50,0x50,0x50,0x0,0x50,0x50,0x7d,
	0x0,0x50,0x0,0x7d,0x50,0x0,0x7d,0x7d,
	0x50,0x0,0x7d,0x7d,0x7d,0x0,0x50,0x0,
	0x0,0x7d,0x7d,0x7d,0x7d,0x7d,0x0,0x0,
	0x0,0x50,0x7d,0x7d,0x7d,0x7d,0x7d,0x7d,
	0x7d,0x7d,0x7d,0x7d,0x7d,0x7d,0x7d,0x7d,
	0x50,0x0,0x7d,0x0,0x0,0x0,0x0,0x50,
	0x0,0x0,0x7d,0x0,0x50,0x0,0x7d,0x7d,
	0x0,0x78,0x50,0x7d,0x50,0x0,0x0,0x7d,
	0x7d,0x7d,0x28,0x0,0x0,0x78,0x7d,0x2a,
	0x2a,0x7d,0x7d,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x28,
	0x0,0x0,0x0,0x7d,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x50,0x0,0x50};
SetWordType TCLParser::setwd14[125] = {0x0,0xaa,0x0,0xab,0xab,0xff,0xab,
	0xaa,0xaa,0xab,0xff,0xff,0xab,0xab,0xab,
	0xab,0xab,0xab,0xab,0x0,0xab,0xab,0xff,
	0x0,0xab,0x0,0xff,0xab,0x0,0xff,0xff,
	0xaa,0x0,0xff,0xff,0xff,0x0,0xab,0x0,
	0x0,0xff,0xff,0xff,0xff,0xff,0x0,0x0,
	0x0,0xab,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xab,0x0,0xfb,0x0,0x0,0x0,0x0,0xaa,
	0x0,0x0,0xff,0x0,0xab,0x0,0xff,0xfb,
	0x0,0xfa,0xaa,0xfb,0xaa,0x0,0x0,0xfb,
	0xff,0xff,0x50,0x0,0x0,0xfb,0xff,0x50,
	0x50,0xff,0xff,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x50,
	0x0,0x0,0x0,0xff,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0xab,0x0,0xab};
SetWordType TCLParser::setwd15[125] = {0x0,0x49,0x0,0x69,0x69,0x7f,0x69,
	0x49,0x49,0x69,0x7f,0x7f,0x69,0x69,0x69,
	0x69,0x69,0x69,0x69,0x0,0x69,0x69,0x7f,
	0x0,0x69,0x0,0x7f,0x69,0x0,0x7f,0x7f,
	0x49,0x0,0x7f,0x7f,0x7f,0x0,0x69,0x0,
	0x0,0x7f,0x7f,0x7f,0x7f,0x7f,0x0,0x0,
	0x0,0x69,0x7f,0x7f,0x7f,0x7f,0x7f,0x7f,
	0x7f,0x7f,0x7f,0x7f,0x7f,0x7f,0x7f,0x7f,
	0x69,0x0,0x7f,0x0,0x0,0x0,0x0,0x49,
	0x0,0x0,0x7f,0x0,0x69,0x0,0x7f,0x7b,
	0x0,0x5b,0xc9,0x7b,0x49,0x0,0x0,0x7f,
	0x7f,0x7f,0x12,0x0,0x0,0x7b,0x7f,0x12,
	0x12,0x7f,0x7f,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x12,
	0x0,0x0,0x0,0x7f,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x69,0x0,0x69};
SetWordType TCLParser::P_OPERATORS_set[16] = {0x0,0x0,0x0,0x0, 0x0,0x0,0xfa,0x7f, 0x0,0x0,0x0,0x0,
	0x0,0x0,0x4,0x0};
SetWordType TCLParser::P_OPERATORS_errset[16] = {0x0,0x0,0x0,0x0, 0x0,0x0,0xfa,0x7f, 0x0,0x0,0x0,0x0,
	0x0,0x0,0x4,0x0};
SetWordType TCLParser::setwd16[125] = {0x0,0x0,0x0,0x0,0x0,0x6f,0x0,
	0x0,0x0,0x0,0x6f,0x6f,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x6f,
	0x0,0x0,0x0,0x6f,0x0,0x0,0x6f,0x6f,
	0x0,0x0,0x6f,0x6f,0x6f,0x0,0x0,0x0,
	0x0,0x6f,0x6f,0x6f,0x6f,0x6f,0x0,0x0,
	0x0,0x0,0xff,0x6f,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0x0,0x0,0x6d,0x0,0x0,0x0,0x0,0x4c,
	0x0,0x0,0x6f,0x0,0x0,0x0,0x6f,0x6d,
	0x0,0x6d,0x4,0x6d,0x0,0x4c,0x4,0x6d,
	0x6f,0x6f,0x6d,0x0,0x0,0x6d,0x6f,0x6f,
	0x6f,0x6f,0x6f,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x6f,
	0x0,0x0,0x0,0xff,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0};
SetWordType TCLParser::setwd17[125] = {0x0,0xcc,0x0,0xcc,0xcc,0xff,0xcc,
	0xcc,0xcc,0xcc,0xff,0xff,0xcc,0xcc,0xcc,
	0xcc,0xcc,0xcc,0xcc,0x0,0xcc,0xcc,0xff,
	0x0,0xcc,0x0,0xff,0xcc,0x0,0xff,0xff,
	0xcc,0x0,0xff,0xff,0xff,0x0,0xcc,0x0,
	0x0,0xff,0xff,0xff,0xff,0xff,0x0,0x0,
	0x0,0xcc,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xcc,0x0,0xff,0x0,0x0,0x0,0x0,0xcd,
	0x0,0x0,0xff,0x0,0xcc,0x0,0xff,0xff,
	0x0,0xff,0xcd,0xff,0xcc,0x1,0x1,0xff,
	0xff,0xff,0xb3,0x0,0x0,0xff,0xff,0xb3,
	0xb3,0xff,0xff,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0xb3,
	0x0,0x0,0x0,0xff,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0xcc,0x0,0xcc};
SetWordType TCLParser::setwd18[125] = {0x0,0x0,0x0,0x48,0x48,0xfd,0x48,
	0x0,0x0,0x48,0xfd,0xfd,0x48,0x48,0x48,
	0x48,0x48,0x48,0x48,0x0,0x48,0x48,0xfd,
	0x0,0x48,0x0,0xfd,0x48,0x0,0xfd,0xfd,
	0x0,0x0,0xfd,0xfd,0xfd,0x0,0x48,0x0,
	0x0,0xfd,0xfd,0xfd,0xfd,0xfd,0x0,0x0,
	0x0,0x48,0xfd,0xfd,0xfd,0xfd,0xfd,0xfd,
	0xfd,0xfd,0xfd,0xfd,0xfd,0xfd,0xfd,0xfd,
	0x48,0x0,0xfd,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0xfd,0x0,0x48,0x0,0xfd,0xfd,
	0x0,0x99,0x2,0xfd,0x0,0x0,0x0,0xfd,
	0xfd,0xfd,0x1,0x0,0x0,0x49,0xfd,0x1,
	0x1,0xfd,0xfd,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x1,
	0x0,0x0,0x0,0xfd,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x48,0x0,0x48};
SetWordType TCLParser::setwd19[125] = {0x0,0xb0,0x0,0xbe,0xbe,0xff,0xbe,
	0xb0,0xb0,0xbe,0xff,0xff,0xbe,0xbe,0xbe,
	0xbe,0xbe,0xbe,0xbe,0x0,0xbe,0xbe,0xff,
	0x0,0xbe,0x0,0xff,0xbe,0x0,0xff,0xff,
	0xb0,0x0,0xff,0xff,0xff,0x0,0xbe,0x0,
	0x0,0xff,0xff,0xff,0xff,0xff,0x0,0x0,
	0x0,0xbe,0xff,0xff,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xbe,0x0,0xff,0x0,0x0,0x0,0x0,0xb0,
	0x0,0x0,0xff,0x0,0xbe,0x0,0xff,0xff,
	0x0,0xf4,0xb0,0xff,0xb0,0x0,0x0,0xff,
	0xff,0xff,0x40,0x0,0x0,0xfe,0xff,0x40,
	0x40,0xff,0xff,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x40,
	0x0,0x0,0x0,0xff,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0xbe,0x0,0xbe};
SetWordType TCLParser::setwd20[125] = {0x0,0x8,0x0,0x8,0x8,0xbb,0x8,
	0x8,0x8,0x8,0xbb,0xbb,0x8,0x8,0x8,
	0x8,0x8,0x8,0x8,0x0,0x8,0x8,0xbb,
	0x0,0x8,0x0,0xbb,0x8,0x0,0xbb,0xbb,
	0x8,0x0,0xbb,0xbb,0xbb,0x0,0x8,0x0,
	0x0,0xbb,0xbb,0xbb,0xbb,0xbb,0x0,0x0,
	0x0,0x8,0xff,0xbb,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0x8,0x0,0x8,0x0,0x0,0x0,0x0,0xa,
	0x0,0x0,0xbb,0x0,0x8,0x0,0xbb,0xbb,
	0x0,0x8,0x8,0xbb,0x8,0x33,0x0,0x8,
	0xbb,0xbb,0x0,0x0,0x0,0x8,0xbb,0xb3,
	0xb3,0xbb,0xbb,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0xb3,
	0x0,0x0,0x0,0xff,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x8,0x0,0x8};
SetWordType TCLParser::setwd21[125] = {0x0,0xa4,0x0,0xa4,0xa4,0xfd,0xa4,
	0xa4,0xa4,0xa4,0xfd,0xfd,0xa4,0xa4,0xa4,
	0xa4,0xa4,0xa4,0xa4,0x0,0xa4,0xa4,0xfd,
	0x0,0xa4,0x0,0xfd,0xa4,0x0,0xfd,0xfd,
	0xa4,0x0,0xfd,0xfd,0xfd,0x0,0xa4,0x0,
	0x0,0xfd,0xfd,0xfd,0xfd,0xfd,0x0,0x0,
	0xa0,0xa4,0xff,0xfd,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0xa4,0x0,0xa4,0x0,0x0,0x0,0x0,0xa4,
	0x0,0x0,0xfd,0x0,0xa4,0x0,0xfd,0xe5,
	0x0,0xa4,0xa4,0xe5,0xa4,0xe5,0xa4,0xa4,
	0xfd,0xfd,0xa4,0x0,0x0,0xa4,0xfd,0xed,
	0xed,0xfd,0xfd,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0xed,
	0x0,0x0,0x0,0xff,0x0,0x0,0x0,0xa0,
	0xa0,0x0,0xa0,0xa4,0x0,0xa4};
SetWordType TCLParser::setwd22[125] = {0x0,0x0,0x0,0x0,0x0,0xf5,0x0,
	0x0,0x0,0x0,0xf5,0xf5,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0xf5,
	0x0,0x0,0x0,0xf5,0x0,0x0,0xf5,0xf5,
	0x0,0x0,0xf5,0xf5,0xf5,0x0,0x0,0x0,
	0x0,0xf5,0xf5,0xf5,0xf5,0xf5,0x0,0x0,
	0x0,0x0,0xff,0xf5,0xff,0xff,0xff,0xff,
	0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x91,
	0x0,0x0,0xf5,0x0,0x0,0x0,0xf5,0x95,
	0x0,0x0,0x90,0x95,0x0,0x91,0x90,0x0,
	0xf5,0xf5,0x0,0x0,0x0,0x0,0xf5,0xd5,
	0xd5,0xf5,0xf5,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0xd5,
	0x0,0x0,0x0,0xff,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0};
SetWordType TCLParser::setwd23[125] = {0x0,0x0,0x0,0x0,0x0,0x3,0x0,
	0x0,0x0,0x0,0x3,0x3,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x3,
	0x0,0x0,0x0,0x3,0x0,0x0,0x3,0x3,
	0x0,0x0,0x3,0x3,0x3,0x0,0x0,0x0,
	0x0,0x3,0x3,0x3,0x3,0x3,0x0,0x0,
	0x0,0x0,0x3,0x3,0x3,0x3,0x3,0x3,
	0x3,0x3,0x3,0x3,0x3,0x3,0x3,0x3,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x2,
	0x0,0x0,0x3,0x0,0x0,0x0,0x3,0x3,
	0x0,0x0,0x2,0x3,0x0,0x3,0x2,0x0,
	0x3,0x3,0x0,0x0,0x0,0x0,0x3,0x3,
	0x3,0x3,0x3,0x0,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x3,
	0x0,0x0,0x0,0x3,0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x0,0x0};
SetWordType TCLParser::ITCL30_CLASS_RESYNC_set[16] = {0x0,0x0,0x0,0xe4, 0x6,0x1e,0x0,0x0, 0x0,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0};
