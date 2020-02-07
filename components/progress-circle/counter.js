/**
 * @module   αCounter
 * @version  0.1.2
 * @author   OXAYAZA {@link https://github.com/OXAYAZA}
 * @license  CC BY-SA 4.0 {@link https://creativecommons.org/licenses/by-sa/4.0/}
 * @requires module:αUtil
 * @see      {@link https://oxayaza.page.link/gitHub_aCounters}
 * @see      {@link https://codepen.io/OXAYAZA/pen/JJryqW}
 * @see      {@link https://oxayaza.page.link/linkedin}
 */
function aCounter ( data ) {
	function Counter ( data ) {
		// Проверка наличия обязательных параметров
		if ( !data || !data.node ) throw Error( 'Missing required aCounter parameters (node).' );

		// Слияние стандартных и полученных параметров
		this.params = Util.merge( [ this.defaults, data ] );

		// Добавление ссылки на прототип в элемент
		this.params.node.counter = this;

		// Если не задано значение счетчика то попробовать определить его из содержимого
		if ( !this.params.to ) {
            
			try { this.params.to = parseFloat( this.params.node.textContent, 10 ); }
			catch ( error ) { throw Error( 'Unable to get aCounter value' ) }
		}

		// Привязка контекста методов прототипа
		this.run = this.run.bind( this );
		return this;
	}

	// Служебные параметры
	Counter.prototype.internal = {
		intervalId: null,
		value:      0,
		loops:      0,
		increment:  0,
		loop:       0
	};

	// Параметры по умолчанию
	Counter.prototype.defaults = {
		node:       null,
		from:       0,
		to:         null,
		duration:   3000,
		refresh:    30,
		formatter:  null,
		onStart:    null,
		onUpdate:   null,
		onComplete: null
	};

	// Запуск счетчика
	Counter.prototype.run = function () {
		clearInterval( this.internal.intervalId );
		this.internal.value     = this.params.from;
		this.internal.loops     = Math.ceil( this.params.duration / this.params.refresh );
		this.internal.increment = ( this.params.to - this.params.from) / this.internal.loops;
		this.internal.loop      = 0;

		// Выброс события запуска
		var event = new CustomEvent( 'counterStart' );
		event.value = ~~this.internal.value;
		if ( this.params.node.dispatchEvent( event ) && this.params.onStart instanceof Function ) {
			this.params.onStart.call( this, ~~this.internal.value );
		}

		// Запуски интервала
		this.internal.intervalId = setInterval( this.update.bind( this ), this.params.refresh );
	};

	// обновление значения счетчика
	Counter.prototype.update = function () {
		this.internal.value = this.accAdd(this.internal.value,JSON.parse(this.internal.increment.toFixed(2))) 
		this.internal.loop++;
		// Выброс события обновления счетчика 
		var event = new CustomEvent( 'counterUpdate' );
		event.value = ~~this.internal.value;
		if ( this.params.node.dispatchEvent( event ) && this.params.onUpdate instanceof Function ) {
			this.params.onUpdate.call( this, ~~this.internal.value );
		}

		// На последнем значении цикла счетчик должен принять конечное значение
		if ( this.internal.loop >= this.internal.loops ) {
			clearInterval( this.internal.intervalId );
			this.internal.value = this.params.to.toFixed(2);

			// Выброс события завершения
			var event = new CustomEvent( 'counterComplete' );
			event.value = ~~this.internal.value;
			if ( this.params.node.dispatchEvent( event ) && this.params.onComplete instanceof Function ) {
				this.params.onComplete.call( this, ~~this.internal.value );
			}
		}

		this.render();
	};

	// Отрисовка значения счетчика
	Counter.prototype.render = function () {
		if ( this.params.formatter instanceof Function ) {
			this.params.node.innerHTML = this.params.formatter.call( this, this.internal.value );
		} else {
			this.params.node.innerHTML = ~~this.internal.value;
		}
    };

    Counter.prototype.accAdd = function (num1,num2) {
		var r1,r2,m;
      try {
        r1 = num1.toString().split('.')[1].length;
      } catch (e) {
        r1 = 0;
      }
      try {
        r2 = num2.toString().split('.')[1].length;
      } catch (e) {
        r2 = 0;
      }
      m = Math.pow(10,Math.max(r1,r2));
      return Math.round(num1 * m + num2 * m) / m ;
	};

	return new Counter( data );
}