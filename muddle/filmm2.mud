; "Test the GC by allocating and GC-ing objects -*-Muddle-*-"

<GC-MON TRUE>

<SET VECS <IVECTOR 210 '#FALSE ()>>

<REPEAT ((PASS 0))
  <SET PASS <+ .PASS 1>>
  <PRINC "FILMM2 pass ">
  <PRINC .PASS>
  <CRLF>

  ; "Allocate new UVECTORs in any gaps"
  <MAPR <>
	#FUNCTION ((V)
		   <COND (<NOT <1 .V>>
			  <PRINC "+">
			  <PUT .V 1 <IUVECTOR <+ 800 <MOD <RANDOM> 400>>
					      '.PASS>>)>)
	.VECS>

  ; "Remove some at random"
  <MAPR <>
	#FUNCTION ((V)
		   <COND (<==? 0 <MOD <RANDOM> 3>>
			  <PRINC "-">
			  <PUT .V 1 #FALSE ()>)>)
	.VECS>

  <CRLF>>