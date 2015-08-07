Ultra Power Matrix Utilities
======
<p><strong>HASKELL</strong></p>
<p><strong>Applies the most basic matrix operations, through cli interaction.</strong></p>

<p>Contains all the basic matrix operations (including finding determinant using La Place algorithm)<p>
<p>The principal Haskell module is Matrix, which includes all the matrix logics.
   Another important Module is Formatter, which wraps all the input formatting and validation to 
   achieve the interface (cli) requirements</p>
<p>This project was mainly intented to improve my Haskell coding skills, although it can be extended. 
   Please, feel encouraged to give it improvements and comments</p>

<h2>Running</h2>
<p>Go to the src directory and type: </p>
<pre>	runhaskell MainAll.hs</pre>
<p><em>This way you will run the user interface which lets you do everything</em></p>
<hr>
<p>You may also feed it with file contents to find out its matrix determinant, to do it: </p>
<pre>	cat ../matrixTextFiles/01.txt | runhaskell MainDet.hs</pre>
<hr>
<p>Another way to run the program, through the compiled files, is going to the bin directory and doing: </p>
<pre>	./MainAll</pre>
