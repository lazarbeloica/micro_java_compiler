package rs.ac.bg.etf.pp1.bl130353d;

import java_cup.runtime.Symbol;

%%

%{

	// ukljucivanje informacije o poziciji tokena
	private Symbol new_symbol(int type) {
		return new Symbol(type, yyline+1, yycolumn);
	}
	
	// ukljucivanje informacije o poziciji tokena
	private Symbol new_symbol(int type, Object value) {
		return new Symbol(type, yyline+1, yycolumn, value);
	}

%}

%cup
%line
%column

%xstate COMMENT

%eofval{
	return new_symbol(sym.EOF);
%eofval}

%%

" " 	{ }
"\b" 	{ }
"\t" 	{ }
"\r\n" 	{ }
"\n" 	{ }
"\f" 	{ }

"program"   { return new_symbol(sym.PROGRAM, yytext()); }
"break"   { return new_symbol(sym.BREAK, yytext()); }
"class"   { return new_symbol(sym.CLASS, yytext()); }
"else"   { return new_symbol(sym.ELSE, yytext()); }
"const"   { return new_symbol(sym.CONST, yytext()); }
"if"   { return new_symbol(sym.IF, yytext()); }
"new"   { return new_symbol(sym.NEW, yytext()); }
"print"   { return new_symbol(sym.PRINT, yytext()); }
"read"   { return new_symbol(sym.READ, yytext()); }
"return"   { return new_symbol(sym.RETURN, yytext()); }
"void"   { return new_symbol(sym.VOID, yytext()); }
"for"   { return new_symbol(sym.FOR, yytext()); }
"extends"   { return new_symbol(sym.EXTENDS, yytext()); }
"continue"   { return new_symbol(sym.CONTINUE, yytext()); }
"static" 	{ return new_symbol(sym.STATIC, yytext()); }

"+" 		{ return new_symbol(sym.PLUS, yytext()); }
"-" 		{ return new_symbol(sym.MINUS, yytext()); }
"*" 		{ return new_symbol(sym.MUL, yytext()); }
"/" 		{ return new_symbol(sym.DIV, yytext()); }
"%" 		{ return new_symbol(sym.MOD, yytext()); }
"==" 		{ return new_symbol(sym.ISEQUAL, yytext()); }
"!=" 		{ return new_symbol(sym.ISNEQUAL, yytext()); }
">" 		{ return new_symbol(sym.GRTHN, yytext()); }
">=" 		{ return new_symbol(sym.GREEQ, yytext()); }
"<" 		{ return new_symbol(sym.LESSTHN, yytext()); }
"<=" 		{ return new_symbol(sym.LESSEQ, yytext()); }
"&&" 		{ return new_symbol(sym.AND, yytext()); }
"||" 		{ return new_symbol(sym.OR, yytext()); }
"=" 		{ return new_symbol(sym.EQUALS, yytext()); }
"+=" 		{ return new_symbol(sym.PLUSEQ, yytext()); }
"-=" 		{ return new_symbol(sym.MINUSEQ, yytext()); }
"*=" 		{ return new_symbol(sym.MULEQ, yytext()); }
"/=" 		{ return new_symbol(sym.DIVEQ, yytext()); }
"%=" 		{ return new_symbol(sym.MODEQ, yytext()); }
"++" 		{ return new_symbol(sym.INC, yytext()); }
"--" 		{ return new_symbol(sym.DEC, yytext()); }
";" 		{ return new_symbol(sym.SEMI, yytext()); }
"," 		{ return new_symbol(sym.COMMA, yytext()); }
"." 		{ return new_symbol(sym.DOT, yytext()); }

"(" 		{ return new_symbol(sym.LPAREN, yytext()); }
")" 		{ return new_symbol(sym.RPAREN, yytext()); }
"{" 		{ return new_symbol(sym.LBRACE, yytext()); }
"}"			{ return new_symbol(sym.RBRACE, yytext()); }
"[" 		{ return new_symbol(sym.LSQUARE, yytext()); }
"]"			{ return new_symbol(sym.RSQUARE, yytext()); }

"//" 		    	 { yybegin(COMMENT); }
<COMMENT> .     	 { yybegin(COMMENT); }
<COMMENT> "\r\n"	 { yybegin(YYINITIAL); }
<COMMENT> "\n" 		 { yybegin(YYINITIAL); }

[0-9]+							{ return new_symbol(sym.NUMBER, new Integer (yytext())); }
([a-z]|[A-Z])[a-z|A-Z|0-9|_]* 	{ return new_symbol (sym.IDENT, yytext()); }
"'"[\40-\176]"'"				{ return new_symbol (sym.CHAR_CONST, new Character(yytext().toCharArray()[1])); }
[ true | false ]				{ return new_symbol( sym.BOOLEAN,  yytext().equals("true") ? true : false ); }

. { System.err.println("Leksicka greska ("+yytext()+") u liniji "+(yyline+1)); }

