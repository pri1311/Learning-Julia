import 'package:flutter/material.dart';
import 'package:calendar_slider/calendar_slider.dart';
import 'package:project_100days/widgets/task_tile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CalendarSliderController _controller = CalendarSliderController();
  late DateTime _selectedDateAppBBar;
  late List<Map<String, Object>> tasks;

  @override
  void initState() {
    super.initState();
    _selectedDateAppBBar = DateTime.now();
    tasks = [
      {
        'id': 0,
        'name': 'Habit 1',
        'days': ['2024-03-03'],
        'streak': 1,
        'last_checked_on': '2024-03-03'
      },
      {
        'id': 1,
        'name': 'Habit 2',
        'days': ['2024-03-03', '2024-03-02'],
        'streak': 2,
        'last_checked_on': '2024-03-03'
      },
      {
        'id': 2,
        'name': 'Habit 3',
        'days': ['2024-03-03'],
        'streak': 1,
        'last_checked_on': '2024-03-03'
      },
      {
        'id': 3,
        'name': 'Habit 4',
        'days': [],
        'streak': 0,
        'last_checked_on': ''
      }
    ];
  }

  void checkCompleted(id) {
    
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    double button_height = MediaQuery.of(context).size.height * 0.075;
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
          padding: const EdgeInsets.all(0),
          height: MediaQuery.of(context).size.height,
          child: Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CalendarSlider(
                  controller: _controller,
                  selectedTileBackgroundColor:
                      Theme.of(context).colorScheme.inversePrimary,
                  initialDate: DateTime.now(),
                  firstDate:
                      DateTime.now().subtract(const Duration(days: 1000)),
                  lastDate: DateTime.now().add(const Duration(days: 1000)),
                  monthYearTextColor: Colors.white,
                  monthYearButtonBackgroundColor:
                      Theme.of(context).colorScheme.inversePrimary,
                  onDateSelected: (date) {
                    setState(() {
                      _selectedDateAppBBar = date;
                    });
                  }),
              // Text(_selectedDateAppBBar.toString()),
              SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    if ((task["streak"] as int) < 100) {
                      // return ListTile(title: Text(task["name"] as String));
                      return HabitTile(
                          habitName: task["name"] as String,
                          habitCompleted: true,
                          onChanged: (value) => {print(value)},
                          settingsTapped: null,
                          deleteTapped: null);
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      height: button_height,
                      child: ElevatedButton(
                        onPressed: () {
                          _controller.goToDay(DateTime.now());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.inversePrimary,
                          textStyle: const TextStyle(color: Colors.black),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: const Text("Go to today"),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      height: button_height,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.inversePrimary,
                          textStyle: const TextStyle(color: Colors.black),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: const Text("Add new habit"),
                      ),
                    ),
                  )
                ],
              )
            ],
          ))),
    );
  }
}
