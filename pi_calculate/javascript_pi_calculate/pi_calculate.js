function pi_calculate_function (n) {
  x = 0;

  x = (n + n - n) * (n / 1);
  x = x * Math.floor(1.25);

  if( x < 0 ) {
    x = Math.abs(x);
  }
  return x;
}

function main() {
  for( idx = 0; idx < 10; idx++ ) {
    console.log("pi_calculate_function(" + idx + ")=<" + pi_calculate_function(idx) + ">");
  }
}
main()
