class ArcDonutChart {
  constructor(baseElement, width, height, arcsCount, setAngle) {
    baseElement.attr("viewBox", "0 0 " + width + " " + height);
    this.baseElement = baseElement.append("g").attr("transform", "translate(" + width / 2 + "," + height / 4 * 3 + ")");
    this.baseElementMin = baseElement.append("g").attr("transform", "translate(" + width / 2 + "," + height / 4 * 3 + ")");;
    this.width = width;
    this.height = height;
    this.arcsCount = arcsCount;
    this.radius = 0.5 * Math.min(this.width, this.height);
    this.len = this.radius / 2;
    this.needleCenterR = this.len / 6 ;
    this.radiusMin = 0.45 * Math.min(this.width, this.height);
    this.arc = d3.arc()
      .innerRadius(0.82 * this.radius)
      .outerRadius(this.radius)
      .startAngle(function (d) { return d.startAngle; })
      .endAngle(function (d) { return d.endAngle; });

    this.arcMin = d3.arc()
      .innerRadius(0.8 * this.radiusMin)
      .outerRadius(this.radiusMin)
      .startAngle(function (d) { return d.startAngle; })
      .endAngle(function (d) { return d.endAngle; });

    var a = Array.from(Array(this.arcsCount).keys());
    this.xScale = d3.scaleBand()
      .domain(a)
      .range(setAngle)
      .paddingInner(0.14)
      .paddingOuter(0.07);

    this.seltext = this.baseElement.append("g")
      .append("text").attr("x", 0.4 * width).attr("y", "0")
      .attr("style", "text-anchor:end;font-size:1.5rem");

    this.selpointer = baseElement.append('g')
      // .append('image')
      // .attr('href', 'https://roboadvisor.asuscomm.com/RoboAdvisor_Customer/images/wer.png')
      // .attr('width', 64)
      // .attr('x', -32)
      // .attr('height', 0.27 * this.height)
      // .attr('y', -0.27 * this.height)
      // .style("transform", "rotate(-90deg)");
      .attr("class", "needle")
      .attr("transform", "translate(" + width / 2 + "," + height / 4 * 3 + ")");
      this.selpointer.append('circle').attr('class', 'needle-center').attr('cx', 0).attr('cy', 0).attr('r', this.needleCenterR);
      this.selpointer.append('path').attr('id', 'client-needle').attr('d', this.recalcPointerPos(0));

    this.transition = function (sel) { return sel.transition(); };
  }
  update(value) {
    this.oldValue = this.newValue !== undefined ? this.newValue : value;
    this.newValue = value;
    this.updateArcs();
    this.updateText();
    this.updatePointer();
  }
  interpolate(t, v) {
    return t * v + (1 - t) * this.oldValue;
  }
  updateArcs() {
    var _this = this;
    var sel = this.baseElement.selectAll("path")
      .data(
        Array.from(Array(this.arcsCount)).map(function (d, i) {
          var t = _this.xScale(i);
          return { startAngle: t, endAngle: t + _this.xScale.bandwidth() };
        }));
    // var colorScale = d3.scaleLinear()
    //   .domain([30, 75, 90])
    //   .range(["rgb(136, 238, 116)", "rgb(255, 188, 73)", "rgb(249, 124, 107)"]);
    var setColor = function (value) {
      if (value < 30) {
        return 'rgb(136,238,116)';
      } else if (value < 75) {
        return 'rgb(255,188,73)';
      } else {
        return 'rgb(249,124,107)';
      }
    };
    var fac = function (i) {
      return function (t) {
        return ((i + 1) / (_this.arcsCount + 1) < _this.interpolate(t, _this.newValue) ? setColor((100 * _this.interpolate(t, _this.newValue)).toFixed(0)) : "#d8d8d8");
      };
    };
    var mod = function (sel) {
      return _this.transition(sel)
        .attrTween("fill", function (d, i) { return fac(i); });
      // .attrTween("class", function (d, i) { return fac(i); });
      // .attr('fill', function (d, i) {return colorScale(i) });
    };
    var selMin = this.baseElementMin.selectAll("path")
      .data(
        Array.from(Array(this.arcsCount)).map(function (d, i) {
          var t = _this.xScale(i);
          return { startAngle: t, endAngle: t + _this.xScale.bandwidth() };
        }));

    mod(sel);
    mod(sel.enter()
      .append("g")
      .append("path"))
      .attr("d", this.arc);
    sel.exit().remove();

    mod(selMin);
    mod(selMin.enter()
      .append("g")
      .style('opacity', '0.3')
      .append("path"))
      .attr("d", this.arcMin);
    selMin.exit().remove();

  }
  updateText() {
    var _this = this;
    var sel = this.seltext._groups[0][0];
    // var colorScale = d3.scaleLinear()
    //   .domain([30, 75, 90])
    //   .range(["rgb(136, 238, 116)", "rgb(255, 188, 73)", "rgb(249, 124, 107)"]);
    var setColor = function (value) {
      if (value < 30) {
        return 'rgb(136,238,116)';
      } else if (value < 75) {
        return 'rgb(255,188,73)';
      } else {
        return 'rgb(249,124,107)';
      }
    }
    this.transition(this.seltext)
      .tween("text", function () {
        return function (t) {
          sel.textContent = (100 * _this.interpolate(t, _this.newValue)).toFixed(0);
          sel.style.fill = setColor((100 * _this.interpolate(t, _this.newValue)).toFixed(0));
        };
      });
  }
  updatePointer() {
    var _this = this;
    var sel = this.selpointer._groups[0][0];
    _this.transition(this.selpointer)
      // .tween("progress", function () {
      //   return function (t) {
      //     sel.style.transform = 'rotate(' + (-90 + 150 * _this.interpolate(t, _this.newValue)).toFixed(0) + 'deg)';
      //   };
      // });
      .tween("progress",function(){
        return function(t){
            d3.select(sel).select('path').attr('d',_this.recalcPointerPos(_this.interpolate(t, _this.newValue)));
        }
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
  recalcPointerPos(perc) {
    var centerX, centerY, leftX, leftY, rightX, rightY, thetaRad, topX, topY;
    thetaRad = this.percToRad(perc / 2);
    centerX = 0;
    centerY = 0;
    topX = centerX - this.len * Math.cos(thetaRad);
    topY = centerY - this.len * Math.sin(thetaRad);
    leftX = centerX - this.needleCenterR * Math.cos(thetaRad - Math.PI / 2);
    leftY = centerY - this.needleCenterR * Math.sin(thetaRad - Math.PI / 2);
    rightX = centerX - this.needleCenterR * Math.cos(thetaRad + Math.PI / 2);
    rightY = centerY - this.needleCenterR * Math.sin(thetaRad + Math.PI / 2);
    
    return "M " + leftX + " " + leftY + " L " + topX + " " + topY + " L " + rightX + " " + rightY;
  }
  percToDeg(perc) {
    return perc * 300;
  }
  percToRad(perc) {
    return this.degToRad(this.percToDeg(perc));
  }
  degToRad(deg) {
    return deg * Math.PI / 180;
  }
}
