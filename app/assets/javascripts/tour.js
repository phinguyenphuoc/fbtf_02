function myFunction() {
  var price = document.getElementById("price").innerHTML;
  var x = document.getElementById("mySelect").value;
  document.getElementById("price").innerHTML = x*price;
}
myFunction();
