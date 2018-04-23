;"From MUDDLE 104 manual, p48  -*-MUDDLE-*-"

<DEFINE ROMAN-PRINT (NUMB)
<COND (<OR <L=? .NUMB 0> <G? .NUMB 3999>>
       <PRINC <CHTYPE .NUMB TIME>>)
      (T
       <RCPRINT </ .NUMB 1000> '![!\M]>
       <RCPRINT </ .NUMB  100> '![!\C !\D !\M]>
       <RCPRINT </ .NUMB   10> '![!\X !\L !\C]>
       <RCPRINT    .NUMB       '![!\I !\V !\X]>)>>

<DEFINE RCPRINT (MODN V)
  <SET MODN <MOD .MODN 10>>
  <COND (<==? 0 .MODN>)
	(<==? 1 .MODN> <PRINC <1 .V>>)
	(<==? 2 .MODN> <PRINC <1 .V>> <PRINC <1 .V>>)
	(<==? 3 .MODN> <PRINC <1 .V>> <PRINC <1 .V>> <PRINC <1 .V>>)
	(<==? 4 .MODN> <PRINC <1 .V>> <PRINC <2 .V>>)
	(<==? 5 .MODN> <PRINC <2 .V>>)
	(<==? 6 .MODN> <PRINC <2 .V>> <PRINC <1 .V>>)
	(<==? 7 .MODN> <PRINC <2 .V>> <PRINC <1 .V>> <PRINC <1 .V>>)
	(<==? 8 .MODN>
	 <PRINC <2 .V>>
	 <PRINC <1 .V>>
	 <PRINC <1 .V>>
	 <PRINC <1 .V>>)
	(<==? 9 .MODN> <PRINC <1 .V>> <PRINC <3 .V>>)>>
