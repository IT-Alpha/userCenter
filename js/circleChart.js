class circleChart {
  constructor(baseElement, width, height, arcsCount) {
    baseElement.attr("viewBox", "0 0 " + width + " " + height);
    this.baseElement = baseElement.append("g").attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");
    this.width = width;
    this.height = height;
    this.arcsCount = arcsCount;
    this.radius = 0.45 * Math.min(this.width, this.height);
    this.endCircleRadius = this.radius / 9;
    this.arc = d3.arc()
      .innerRadius(0.9 * this.radius)
      .outerRadius(this.radius)
      .startAngle(function (d) { return d.startAngle; })
      .endAngle(function (d) { return d.endAngle; });
    this.arcDummy = d3.arc()
      .innerRadius(0.95 * this.radius - 1)
      .outerRadius(0.95 * this.radius)
      .startAngle(-Math.PI);
    var a = Array.from(Array(this.arcsCount).keys());

    this.xScale = d3.scaleBand()
      .domain(a)
      .range([0, 2 * Math.PI])
      .paddingInner(0.3)
      .paddingOuter(0.2);

    this.seltext = this.baseElement.append("g")
      .append("text")
      .attr("x", '0').attr("y", '10')
      .attr('fill', '#00AAFF')
      .attr("style", "text-anchor:middle;font-size:1.5rem");
    this.transition = function (sel) { return sel.transition(); };
    this.format = '%';
    this.textMax = 100;

    var _this = this;
    var background = _this.baseElement
      .append("g").attr('class', 'background')
      .selectAll("path")
      .data(
        Array.from(Array(_this.arcsCount)).map(function (d, i) {
          var t = _this.xScale(i);
          return { startAngle: t, endAngle: t + _this.xScale.bandwidth() };
        }));
    background.enter()
      .append("g")
      .append("path")
      .attr('fill', '#d8d8d8')
      .attr("d", this.arc);
    background.exit().remove();

    this.circle = this.baseElement.append('g')
      .attr('class', 'circle')
      .append('path')
      .style('fill', '#00AAFF')
      .datum({ 'startAngle': -Math.PI });


    this.endCircle = _this.baseElement.append('g').append('circle')
      .attr('r', this.endCircleRadius)
      .attr("transform", 'translate(0,' + (0.95 * this.radius) + ')')
      .style("stroke", "#00AAFF")
      .style('stroke-width', this.endCircleRadius / 2)
      .style('fill', '#fff');
  }
  update(value) {
    this.oldValue = this.newValue !== undefined ? this.newValue : value;
    this.newValue = value;
    this.updateArcs();
    this.updateText();
  }
  interpolate(t, v) {
    return t * v + (1 - t) * this.oldValue;
  }
  updateArcs() {
    var _this = this;

    this.transition(_this.circle).attrTween("d", function (d) {
      return function (t) {

        d.endAngle = _this.interpolate(t , _this.newValue * 2 * Math.PI) - Math.PI;
        var pathDummyCircle = _this.arcDummy(d);
        if (pathDummyCircle.includes('A')) {
          var coordinate = pathDummyCircle.split("L")[1].split("A")[0];
          _this.endCircle.attr('transform', 'translate(' + coordinate + ')');
        }
        
        return _this.arc(d)
      };
    });
  }
  updateText() {
    var _this = this;
    var sel = this.seltext._groups[0][0];
    this.transition(this.seltext)
      .tween("text", function () {
        return function (t) {
          sel.textContent = (_this.textMax * _this.interpolate(t, _this.newValue)).toFixed(0) + _this.format;
        };
      });
  }
  shuffle(array) {
    var currentIndex = array.length;
    var temporaryValue;
    var randomIndex;
    // While there remain elements to shuffle...
    while (0 !== currentIndex) {
      if (window.CP.shouldStopExecution(0)) break;
      // Pick a remaining element...
      randomIndex = Math.floor(Math.random() * currentIndex);
      currentIndex -= 1;
      // And swap it with the current element.
      temporaryValue = array[currentIndex];
      array[currentIndex] = array[randomIndex];
      array[randomIndex] = temporaryValue;
    } window.CP.exitedLoop(0);
    return array;
  }
}
