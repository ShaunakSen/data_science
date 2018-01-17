DAX is a functional language

innermost function is executed first and then it goes to outer functions

DAX is a programming language

Each col should have a strong data type

DAX Types
_________________________________

Int(64 bit)
Decimal
Currency
Date
Bool
String
Binary Obj

Operator Overloading
_________________________________

- Operators are not strongly typed
- The result depends on the inputs

"5" + "4" = 9

+ tries to add. So returns a no

5 & 4 = "54"

&: str concat operator

Conversions happen automatically

DateTime data type 
_________________________________

Floating point value

Int part
No of days after Dec 30, 1899

Decimal part:
seconds: 1/(24*60*60)

DateTime expr:

Date +- 1: day b4/after

Calculated Columns and Calculated Measures
_________________________________


CC are part of ur table in the data model
CM are calculated on the fly as u use them in visualization

CC:
_________________________________

Syntax for CC:

CC is calculated row by row

If u want to get value for single row, u must specify it

'table_name'[col_name]

Sales Amount = 'Sales'[Unit Price] * 'Sales'[Quantity]

if table_name contains sapce and other special chars '' are reqd

Sales Amount = [Unit Price] * [Quantity]: also valid

But always use table_name

CC are computed at refresh time, so when u refresh ur model, CC will be computed

Drawback: use RAM, uses space in ur model

say ur table has 1 bil rows, lot of RAM will be used


Say now u wanna calculate Gross Margin

Gross Margin = Sales[Quantity] * ( Sales[Net price] - Sales[Unit cost] )

Gross Margin Pct = Sales[Gross Margin]/Sales[Sales Amount]


But GrossBut Margin Pct is not a calculation that should be done row by row and aggregated
First we should aggregate, then do the division

For this we need Measures

CM
_________________________________

Gross Margin Pct = Sales[Gross Margin]/Sales[Sales Amount]

But we get a warning here. In Measures there is no concept of current row

Measures are calculated at Report level or at aggregated values

Gross Margin Pct = SUM(Sales[Gross Margin])/SUM(Sales[Sales Amount])

I want to SUM all the rows that are in the current cell of the chart I'm using

Measures are not stored in the model. Just the source code of the Measures are stored in the model

Calculation happens at query time when user starts building reports

We use CC when we want to slice or filter on the value. So we need a physical column


Aggregation Functions
_________________________________

SUM, AVERAGE, MIN, MAX

Works only on  Numeric Columns

All these functions are only able to aggregate a SINGLE col

SUM( Order[Price] )

SUM( Order[Price] * Order[Quantity]) -> DOES NOT WORK

Soln: create a CC for  Order[Price] * Order[Quantity] then use SUM on it

But CC have drawbacks

Other soln: Use <<X>> Aggregators:

Have similar names

X aggregators receive 2 params: table and expr

They iterate row by row on the table and compute the expr

SUMX, AVERAGEX, MINX, MAXX

Total Sales := SUMX(
						Sales,
						Sales[Net Price] * Sales[Quantity]
						

						
Useful Functions:
_________________________________

Counting Values:

COUNT(only for numeric cols)
COUNTA(Counts anything but blanks)
COUNTBLANKS
COUNTROWS
DISTINCTCOUNT

Logical Functions:

AND OR NOT IF IFERROR

AND(A,B) == A && B

Information Functions:

Provide you info about expr

ISBLANK ISNUMBER ISTEXT ISNOTTEXT ISERROR

MAX and MIN:

Used both as aggregators and to compare values

=MAX(Sales[Sales Amount])

=MAX(Sales[Sales Amount], Sales[ListPrice])

Mathematical Functions like LOG, SQRT, ABS etc are also there. SImilar to Excel

DIVIDE Functions:

Divide is useful to avoid IF to check for zero denominators

IF (
		Sales[Sales Amount] <> 0,
		A/B,
		0
)

DIVIDE(
		A,
		B,
		0
)

Text Functions: Similar to Excel: LEN ,MID, CONCATE etc

Date Functions: Similar to Excel

But time intelligence functions can be done in a diff way, using a Date Table

Using Vars in DAX Expressions
_________________________________

Very useful to avoid repeating subexpressions in ur code

Corrected Quantity :=

	VAR 
		TotalQuantity = SUM( Sales[Quantity] )
		
	RETURN
		
		IF (
				TotalQuantity > 1000,
				TotalQuantity * 0.95,
				TotalQuantity * 1.25
			)
			
VAR ensures that evaluation of expr ie SUM( Sales[Quantity] ) happens only once

If instead of SUM we had a very complex expr, we would not have to evaluate it multiple times






























