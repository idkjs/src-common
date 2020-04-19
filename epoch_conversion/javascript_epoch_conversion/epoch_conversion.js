
function computeDateDoy ( year, month, mday ) {
  var n1 = Math.floor((275 * month) / 9);
  var n2 = Math.floor((month + 9) / 12);
  var n3 = (1 + Math.floor((year - 4 * Math.floor(year / 4) + 2) / 3));
  var n = n1 - (n2 * n3) + mday - 30;

  return n;
}

function datetimeToEpoch ( years, months, mday, hours, mins, secs ) {
  var epoch_start = 1970;
  var total_days = 0;
  var total_secs = 0;

  while( epoch_start < years ) {
    total_days = total_days + computeDateDoy(epoch_start, 12, 31);
    epoch_start = epoch_start + 1;
  }
  total_days = total_days + computeDateDoy(years, months, mday - 1);
  total_secs = (total_days * 86400) + (hours * 60 * 60) + (mins * 60) + secs;
  return total_secs;
}

function main() {
  var utc = new Date();
  var year = utc.getUTCFullYear();
  var month = utc.getUTCMonth() + 1; //months from 1-12
  var day = utc.getUTCDate();
  var hour = utc.getUTCHours();
  var min = utc.getUTCMinutes();
  var sec = utc.getUTCSeconds();

  console.log(datetimeToEpoch(year,month,day,hour,min,sec));
}
main()
