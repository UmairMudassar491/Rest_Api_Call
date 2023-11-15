import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:slider_task/models/user_model.dart';
import 'package:slider_task/services/user_api.dart';
import 'package:slider_task/widgets/custom_tile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController _pageController;
  final Connectivity _connectivity = Connectivity();
  List<UserModel> users = [];
  double _currentPage = 0;
  bool isLoading = true;
  bool isConnected = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0;
      });
    });

    _connectivity.onConnectivityChanged.listen((event) {
      setState(() {
        isConnected = event != ConnectivityResult.none;
        if (isConnected) {
          fetchUsers();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  Future<void> fetchUsers() async {
    final response = await UserApi.fetchUsers();
    setState(() {
      users = response;
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider Task'),
      ),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: fetchUsers,
          child: isConnected
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  height: MediaQuery.of(context).size.height,
                  child: PageView.builder(
                    itemCount: users.length,
                    physics: const ClampingScrollPhysics(),
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return sliderPageView(index);
                    },
                  ),
                )
              : const Center(
                  child: Text('No internet connection'),
                ),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget sliderPageView(int index) {
    final user = users[index];
    final image = user.pic.medium;
    final name = user.fullName;
    final gender = user.gender;
    final email = user.email;
    final phone = user.phone;
    final cell = user.cell;
    final age = user.dob.age.toString();
    final city = user.location.city;
    final country = user.location.country;
    final street = user.fullStreet;
    final state = user.location.state;

    final scaleFactor = _calculateScaleFactor(index);
    return Transform.scale(
      scale: scaleFactor,
      child: Container(
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage("assets/images/profile_bg.jpg"),
                fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(10)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(image),
              ),
              const SizedBox(height: 20.0),
              CustomListTile(leadingText: "Name:", titleText: name),
              CustomListTile(leadingText: "Gender:", titleText: gender),
              CustomListTile(leadingText: "Age:", titleText: age),
              CustomListTile(leadingText: "Email:", titleText: email),
              CustomListTile(leadingText: "Phone:", titleText: phone),
              CustomListTile(leadingText: "Cell:", titleText: cell),
              CustomListTile(leadingText: "Street:", titleText: street),
              CustomListTile(leadingText: "City:", titleText: city),
              CustomListTile(leadingText: "State:", titleText: state),
              CustomListTile(leadingText: "Country:", titleText: country),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateScaleFactor(int index) {
    final diff = (index - _currentPage).abs();
    if (diff > 1) {
      return 0.8;
    } else {
      return 1.0 - diff * 0.15;
    }
  }
}
