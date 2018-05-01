; "Test the GC by filling memory with lots of objects -*-Muddle-*-"

<GC-MON TRUE>

<PRINTSTRING "FILMEM starting">

<REPEAT ((I 0) (VECS ()))
  <COND (<==? <MOD .I 100> 0> <PRINT .I>)>
  <SET VECS <CONS <IUVECTOR 1024 '.I> .VECS>>
  <SET I <+ .I 1>>>