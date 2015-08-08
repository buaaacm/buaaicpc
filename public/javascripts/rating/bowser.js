// Generated by CoffeeScript 1.9.3
(function() {
  this.teams = ["TheWaySoFar", "Damocles", "undetermined", "TDL", "LovelyDonuts", "NewBeer", "TheThreeMusketeers", "I-PPPei+", "Prometheus", "Nostalgia", "Time After Time", "TriMusketeers", "null"];

  this.solve = function() {
    var array, dic, ele, i, j, k, l, len, rank, ref, ref1, ref2, res, res_rating, res_team, table, team;
    dic = {};
    ref = this.teams;
    for (i = j = 0, len = ref.length; j < len; i = ++j) {
      team = ref[i];
      dic[team] = i;
    }
    array = $('.list>li');
    array = (function() {
      var k, len1, results;
      results = [];
      for (k = 0, len1 = array.length; k < len1; k++) {
        ele = array[k];
        results.push(ele.innerText);
      }
      return results;
    })();
    rank = $('.rank>li');
    rank = (function() {
      var k, len1, results;
      results = [];
      for (k = 0, len1 = rank.length; k < len1; k++) {
        ele = rank[k];
        results.push(parseInt(ele.innerText));
      }
      return results;
    })();
    table = (function() {
      var k, ref1, results;
      results = [];
      for (i = k = 0, ref1 = this.teams.length; 0 <= ref1 ? k < ref1 : k > ref1; i = 0 <= ref1 ? ++k : --k) {
        results.push(0);
      }
      return results;
    }).call(this);
    for (i = k = 0, ref1 = array.length; 0 <= ref1 ? k < ref1 : k > ref1; i = 0 <= ref1 ? ++k : --k) {
      if (dic[array[i]] !== void 0) {
        table[dic[array[i]]] = rank[i];
      }
    }
    console.log(table);
    if (this.table == null) {
      this.table = [];
    }
    if (this.contest_num == null) {
      this.contest_num = 1;
    }
    this.table.push(table);
    res = this.build(this.table, this.teams);
    res_team = $('.team>li');
    res_rating = $('.rating>li');
    for (i = l = 0, ref2 = this.teams.length; 0 <= ref2 ? l < ref2 : l > ref2; i = 0 <= ref2 ? ++l : --l) {
      res_team[i].innerHTML = res[i].teamName;
      res_rating[i].innerHTML = parseInt(res[i].rating);
    }
    ++this.contest_num;
    $('#contest')[0].innerHTML = "Contest #" + this.contest_num;
    return $('#rating')[0].innerHTML = "Rating #" + (this.contest_num - 1);
  };

  this.showNow = function() {
    var i, j, ref, res, res_rating, res_team;
    this.table = [[1, 3, 2, 5, 4, 6, 7, 11, 9, 12, 13, 10, 8], [1, 6, 7, 5, 11, 2, 4, 3, 8, 10, 13, 12, 9], [1, 3, 2, 4, 5, 11, 8, 12, 7, 9, 10, 13, 6], [1, 4, 2, 3, 7, 10, 5, 9, 8, 11, 13, 12, 6], [1, 2, 4, 3, 5, 11, 7, 9, 8, 10, 13, 12, 6], [2, 9, 1, 3, 4, 8, 6, 10, 7, 13, 5, 12, 11]];
    this.contest_num = table.length + 1;
    res = this.build(table, this.teams);
    res_team = $('.team>li');
    res_rating = $('.rating>li');
    for (i = j = 0, ref = this.teams.length; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
      res_team[i].innerHTML = res[i].teamName;
      res_rating[i].innerHTML = parseInt(res[i].rating);
    }
    $('#contest')[0].innerHTML = "Contest #" + this.contest_num;
    return $('#rating')[0].innerHTML = "Rating #" + (this.contest_num - 1);
  };

}).call(this);

//# sourceMappingURL=bowser.js.map
