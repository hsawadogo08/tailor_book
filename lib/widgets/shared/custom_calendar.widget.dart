import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/constants/color.dart';
import 'package:tailor_book/widgets/shared/custom_button.widget.dart';

class CustomCalendar extends StatefulWidget {
  final DateTime currentDate;
  const CustomCalendar({
    super.key,
    required this.currentDate,
  });

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late DateTime _currentDate;

  @override
  void initState() {
    _currentDate = widget.currentDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: primaryColor,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context, _currentDate);
            },
            child: const Icon(
              Icons.close,
              color: kWhite,
              size: 30,
            ),
          ),
          title: Text(
            "Ajouter la date du Rendez-vous",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: (width / 5) * 2,
                child: CustomButton(
                  buttonText: "Annuler",
                  buttonSize: 16,
                  pH: 24,
                  buttonColor: secondaryColor,
                  borderColor: secondaryColor,
                  btnTextColor: kWhite,
                  buttonFonction: () {
                    Navigator.pop(context, _currentDate);
                  },
                ),
              ),
              SizedBox(
                width: (width / 5) * 2,
                child: CustomButton(
                  buttonText: "Valider",
                  buttonSize: 16,
                  pH: 24,
                  buttonColor: primaryColor,
                  borderColor: primaryColor,
                  btnTextColor: kWhite,
                  buttonFonction: () {
                    Navigator.pop(context, _currentDate);
                  },
                ),
              ),
            ],
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CalendarCarousel<Event>(
            onDayPressed: (DateTime date, List<Event> events) {
              setState(() => _currentDate = date);
            },
            weekendTextStyle: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w700,
            ),
            thisMonthDayBorderColor: Colors.grey,
            weekFormat: false,
            height: 420.0,
            locale: "fr",
            selectedDateTime: _currentDate,
            daysHaveCircularBorder: false,
            todayBorderColor: secondaryColor,
            todayButtonColor: secondaryColor,
            selectedDayBorderColor: primaryColor,
            selectedDayButtonColor: primaryColor,
          ),
        ),
      ),
    );
  }
}
