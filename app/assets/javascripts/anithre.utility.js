if (typeof Stool === 'undefined') {
  var Anithre = {};
}

Anithre.Utility = {
  nl2br: function(str) {
    return str.replace(/[\n\r]/g, '<br />');
  },

  createHash: function(hash, key, value) {
    if (hash == null) {
      hash = {}
    }
    return hash[key] = value;
  },

  numberWithDelimiter: function(num) {
    if (num == null) return num;
    var num_str = new String(num).replace(/,/g, '');
    while(num_str != (num_str = num_str.replace(/^(-?\d+)(\d{3})/, '$1,$2')));
    return num_str;
  },

  formatDate: function(targetDate, format) {
    if (targetDate == null) {
      targetDate = new Date();
    }
    if (format == null) {
      format = '%Y-%m-%d';
    }
    var _format = format;
    var year = targetDate.getFullYear();
    var month = targetDate.getMonth() + 1;
    var day = targetDate.getDate();
    month = ('0' + month).slice(-2);
    day = ('0' + day).slice(-2);
    var hour = targetDate.getHours();
    var minute = targetDate.getMinutes();
    var second = targetDate.getSeconds();

    _format = _format.replace('%Y', year);
    _format = _format.replace('%m', month);
    _format = _format.replace('%d', day);
    _format = _format.replace('%H', hour);
    _format = _format.replace('%M', minute);
    _format = _format.replace('%S', second);

    return _format;
  },

  currentDate: function(format) {
    return Anithre.Utility.formatDate(new Date(), format);
  },

  sinceDate: function(targetDate, sinceDay, format) {
    return Anithre.Utility.addDate(targetDate, sinceDay, format);
  },

  agoDate: function(targetDate, agoDay, format) {
    return Anithre.Utility.addDate(targetDate, agoDay * -1, format);
  },

  addDate: function(targetDate, addDay, format) {
    if (targetDate == null) {
      targetDate = new Date();
    }
    if (addDay == null) {
      since = 1;
    }
    var _targetDate = targetDate;
    _targetDate = new Date(_targetDate.getFullYear(),
    _targetDate.getMonth(),
    _targetDate.getDate() + addDay,
    _targetDate.getHours(),
    _targetDate.getMinutes(),
    _targetDate.getSeconds());

    return Anithre.Utility.formatDate(_targetDate, format);
  }
}
