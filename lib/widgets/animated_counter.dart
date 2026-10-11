import 'package:flutter/material.dart';

class AnimatedCounter extends StatefulWidget {
  final int initialValue;
  final int maxValue;
  final Duration animationDuration;
  final Color primaryColor;

  const AnimatedCounter({
    super.key,
    this.initialValue = 0,
    this.maxValue = 10,
    this.animationDuration = const Duration(milliseconds: 300),
    this.primaryColor = Colors.deepPurple,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with TickerProviderStateMixin {
  late int _value;

  late AnimationController _scaleController;
  late AnimationController _buttonController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();

    _value = widget.initialValue;

    _scaleController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeInOut,
      ),
    );

    _buttonAnimation = Tween<double>(
      begin: 1.0,
      end: 1.25,
    ).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.elasticOut,
      ),
    );
  }

  void _animateCounter() {
    _scaleController.forward().then((_) {
      _scaleController.reverse();
    });
  }

  void _animateButton() {
    _buttonController.forward().then((_) {
      _buttonController.reverse();
    });
  }

  void _increment() {
    if (_value < widget.maxValue) {
      setState(() {
        _value++;
      });

      _animateCounter();
      _animateButton();
    }
  }

  void _decrement() {
    if (_value > 0) {
      setState(() {
        _value--;
      });

      _animateCounter();
      _animateButton();
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress =
        widget.maxValue == 0 ? 0.0 : _value / widget.maxValue;

    final isMax = _value == widget.maxValue;

    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: child,
                );
              },
              child: AnimatedContainer(
                duration: widget.animationDuration,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isMax
                      ? Colors.green
                      : widget.primaryColor,
                ),
                child: Text(
                  '$_value',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: 0,
                end: progress,
              ),
              duration: widget.animationDuration,
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  value: value,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(10),
                  color: widget.primaryColor,
                );
              },
            ),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: _buttonAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _buttonAnimation.value,
                  child: child,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _decrement,
                    icon: const Icon(Icons.remove),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    onPressed: _increment,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}