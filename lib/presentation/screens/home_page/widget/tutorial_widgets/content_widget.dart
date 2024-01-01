
import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:flutter/material.dart';

class SeventhContent extends StatelessWidget {
  const SeventhContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "lib/assets/6c.jpg",
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Congratulations! \n You\'ve completed the tutorial!',
            textAlign: TextAlign.center,
            style:
                text_theme().copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class SixthContent extends StatelessWidget {
  const SixthContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "lib/assets/5c.jpg",
            fit: BoxFit.fill,
          ),
          Text(
              'Visualize your money flow! \n Check out analytics now!',
              textAlign: TextAlign.center,
              style: text_theme()
                  .copyWith(fontSize: 16)),
        ],
      ),
    );
  }
}

class FifthContent extends StatelessWidget {
  const FifthContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "lib/assets/4c.jpg",
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
              "Don't let brilliant ideas slip away! \n Tap into our reminders and never miss a beat!'",
              textAlign: TextAlign.center,
              style: text_theme()
                  .copyWith(fontSize: 16)),
        ],
      ),
    );
  }
}

class FourthContent extends StatelessWidget {
  const FourthContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "lib/assets/3c.jpg",
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
              '"Search, sort, and filter like a boss! \nManage your transaction history hassle-free!"',
              textAlign: TextAlign.center,
              style: text_theme()
                  .copyWith(fontSize: 16)),
        ],
      ),
    );
  }
}

class ThirdContent extends StatelessWidget {
  const ThirdContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "lib/assets/2c.jpg",
            fit: BoxFit.fill,
          ),
          Text(
              '"Play it your way! \n Stick to defaults or jazz it up by adding your own categories!"',
              textAlign: TextAlign.center,
              style: text_theme()
                  .copyWith(fontSize: 16)),
        ],
      ),
    );
  }
}

class SecondContent extends StatelessWidget {
  const SecondContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "lib/assets/1c.jpg",
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
              '"Money magic awaits! Add transactions, unlock wonders!"',
              textAlign: TextAlign.center,
              style: text_theme()
                  .copyWith(fontSize: 16)),
        ],
      ),
    );
  }
}

class FirstContent extends StatelessWidget {
  const FirstContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "lib/assets/Fc.jpg",
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 20,
          ),
          Text('Welcome to BudgetBee!',
              style: text_theme_h()
                  .copyWith(fontSize: 16)),
        ],
      ),
    );
  }
}
