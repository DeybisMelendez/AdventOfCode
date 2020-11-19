var input="1321131112";

function speak(n) {
 var newStr = "";
 var count=0;
 var currChar = n[0];
 for( var i=0; i<n.length; i++ ) {
   if( currChar == null || currChar == n[i] ) {
     count += 1;
   } else {
     newStr += count + currChar;
     count=1
     currChar=n[i];
   }
 }
 newStr += count + currChar;

 return newStr;
}

for( i=0; i<50; i++ ) {input = speak(input); console.log(i)} 
console.log(input.length)