
PS = 5 #score of each problem

PT = 2 #score of each training problem

global = @

@series = []

angular.module('bcpc-rating', [
  'as.sortable'
])

.controller 'main', ($scope)->

  $scope.currentRanks = [[1,5,4,6,10,3,8,7,2,9,13,11,12,14],[1,3,8,5,13,4,7,6,2,9,10,11,12,14],[1,10,7,4,12,2,9,6,3,5,13,11,8,14],[2,5,6,1,13,4,3,10,7,11,12,9,8,14],[1,7,3,14,12,4,5,6,2,9,11,8,10,13]]
  $scope.problemCount = [38,26,25,24,14,29,23,23,33,19,14,18,19,10,0]
  $scope.trainingCount = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
  $scope.updatedDate = new Date("Thu Aug 10 2017 17:55:19 GMT+0800")

  $scope.PS = PS

  $scope.PT = PT

  series = []

  $scope.teamNames = ["three investigators", "deticxe", "ACMakeMeHappier", "ResuscitatedHope", "sto orz", "Ascender", "#include", "L.I.P", "heynihao", "terminator", "tan90", "tvcr", "TooFarTooClose", "Miscellaneous"];

  teamDic = {}
  for team,i in $scope.teamNames
    teamDic[team] = i

  $scope.teamList = (team for team in $scope.teamNames)

  $scope.result = ({name:team,rating:1000} for team in $scope.teamNames)

  $scope.dragControlListeners=
    itemMoved: (event)->
      console.log event
    orderChanged: (event)->
      console.log event

  $scope.calc = ()->
    rankDic = {}
    for team,i in $scope.teamList
      rankDic[team] = i+1
    rank = (rankDic[team] for team in $scope.teamNames)
    $scope.currentRanks.push rank
    update()

  update = ()->
    $scope.currentRanks ?= []
    series = ({name:team,data:[]} for team in $scope.teamNames)
    res = global.calc($scope.currentRanks, series, $scope.teamNames.length)
    $scope.result = ({name:team,rating: parseInt(res[i])} for team,i in $scope.teamNames)

    for team,i in $scope.result
      team.rating += $scope.problemCount[i]*PS
      team.rating += $scope.trainingCount[i]*PT
      for rating,j in series[i].data
        series[i].data[j] += $scope.problemCount[i]*PS
        series[i].data[j] += $scope.trainingCount[i]*PT

    $scope.result.sort(
      (a,b)->
        if a.rating < b.rating
          return 1
        return -1
    )
    $scope.drawChart()
    return
  $scope.update = update
  $scope.reset = ()->
    $scope.currentRanks = []#[[4,9,2,1,10,6,3,8,5,7,11,12],[2,4,3,1,10,5,6,7,8,12,11,9]]
    update()

  $scope.drawChart = ()->
    global.series ?= []
    $("#panel").highcharts
      title:
        text: "Rating变化图"
        x: -20 #center

      subtitle:
        text: "Source: 北航ACM集训队"
        x: -20

      xAxis:
        categories: [1..100]

      yAxis:
        title:
          text: "Rating"

        plotLines: [
          value: 0
          width: 1
          color: "#808080"
        ]

      tooltip:
        valueSuffix: ""
        pointFormatter: ()->
          rank = $scope.currentRanks[@x][teamDic[@series.name]]
          if @x == 0
            return "<span style='color:#{@color}'>\u25CF</span> #{@series.name}: <b>#{@y}</b><br/><b>Rank:#{rank} </b>"
          else
            delta = @y-@series.data[@x-1].y
            sign = '+'
            sign = '' if delta < 0
            return "<span style='color:#{@color}'>\u25CF</span> #{@series.name}: <b>#{@y}</b><br/><b>#{sign}#{delta}</b><br/><b>Rank: #{rank}</b>"

      legend:
        layout: "vertical"
        align: "right"
        verticalAlign: "middle"
        borderWidth: 0

      series: series
    return

  $scope.drawChart()

  fileExport = (data, fileName, extension)->
    aLink = document.createElement("a")
    blob = new Blob([data])
    evt = document.createEvent("MouseEvents")
    evt.initEvent("click", false, false)
    aLink.download = fileName + "." + extension
    aLink.href = URL.createObjectURL(blob)
    aLink.dispatchEvent(evt)

  $scope.downloadRank = ()->
    data = "
           $scope.currentRanks = #{JSON.stringify $scope.currentRanks}   \n
                                                                         \n
           $scope.problemCount = #{JSON.stringify $scope.problemCount}   \n
                                                                         \n
           $scope.trainingCount = #{JSON.stringify $scope.trainingCount} \n
                                                                        \n
           $scope.updatedDate = new Date(\"#{new Date()}\")\n
           "

    fileExport(data, "rating_save_#{(new Date())}", "txt")

  $scope.color = (rank)->
    return "gold" if rank <= 2
    return "silver" if rank <= 5
    return "brown" if rank <=8
    return "white"
  update()
