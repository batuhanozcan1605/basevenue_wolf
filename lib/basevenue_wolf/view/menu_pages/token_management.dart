import 'package:basevenue_wolf/basevenue_wolf/view_model/messages_view_model.dart';
import 'package:basevenuewolf_sdk/basevenuewolf_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_web3/ethereum.dart';
import 'package:provider/provider.dart';
import '../../color_palette.dart';
import '../../consts.dart';
import '../../utilities/propmts.dart';
import '../../utilities/utilities.dart';

class TokenManagementPage extends StatefulWidget {
  const TokenManagementPage({super.key});

  @override
  _TokenManagementPageState createState() => _TokenManagementPageState();
}

class _TokenManagementPageState extends State<TokenManagementPage> {
  bool _isFormExpanded = false;
  String? walletAddress;
  String? tokenContractAddress;

  @override
  void initState() {
    super.initState();
    fetchWalletAddress();
  }

  /// Requests account access and saves the first wallet address.
  Future<void> fetchWalletAddress() async {
    try {
      // Request account access (this line assumes you have a valid 'ethereum'
      // object available from your web3/JS interop, e.g. via flutter_web3 or similar).
      final accounts = await ethereum!.requestAccount();
      if (accounts.isNotEmpty) {
        setState(() {
          walletAddress = accounts.first;
        });
        print("Wallet Address: $walletAddress");
        final sdk = BasevenueWolfSDK();
        final tca = await sdk.getUserTokenAddress(walletAddress!);
        print("tca $tca");
        setState(() {
          tokenContractAddress = tca;
        });
      } else {
        print("No accounts returned.");
      }
    } catch (error) {
      print("Error fetching wallet address: $error");
    }
  }

  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _extrasController = TextEditingController();
  final TextEditingController _tokenNameController = TextEditingController();
  final TextEditingController _tokenSymbolController = TextEditingController();
  final TextEditingController _tokenFunctionalityController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final sdk = BasevenueWolfSDK();

    return Scaffold(
      backgroundColor: ColorPalette.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80),
            // Supply Information Cards
            SizedBox(
              height: 150,
              child: tokenContractAddress == null
                  ? Center(
                child: Row(
                  children: [
                    _buildInfoCard("Total Supply", ""),
                    SizedBox(width: 16),
                    _buildInfoCard("Circulating Supply", ""),
                  ],
                )
              )
                  : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FutureBuilder<List<dynamic>>(
                      future: Future.wait([
                        sdk.getTokenTotalSupply(tokenContractAddress!),
                        sdk.getTokenSymbol(tokenContractAddress!),
                      ]),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return _buildInfoCard("Total Supply", "Loading...");
                        } else if (snapshot.hasError) {
                          return _buildInfoCard("Total Supply", "Error");
                        } else if (snapshot.hasData) {
                          BigInt totalSupplyRaw = snapshot.data![0] as BigInt;
                          String tokenSymbol = snapshot.data![1] as String;
                          String totalSupplyFormatted =
                              "${Utilities.formatTotalSupply(totalSupplyRaw)} $tokenSymbol";
                          return _buildInfoCard("Total Supply", totalSupplyFormatted);
                        } else {
                          return _buildInfoCard("Total Supply", "N/A");
                        }
                      },
                    ),
                    SizedBox(width: 16),
                    _buildInfoCard("Circulating Supply", "0 TOKEN"),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),

            // Create Token Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorPalette.primaryVariant, // Button background
                side: BorderSide(color: ColorPalette.primaryVariant, width: 1), // Border color & width
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
              ),
              onPressed: () {
                setState(() {
                  _isFormExpanded = !_isFormExpanded;
                });
              },
              child: Text("Create token for your project.", style: TextStyle(color: Colors.white),),
            ),

            SizedBox(height: 16),

            // Expanded Form
            if (_isFormExpanded) Expanded(child: _buildTokenCreationForm()),

            SizedBox(height: 8),
            // Submit Token Button
            if (_isFormExpanded) Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {

                      String projectName = _projectNameController.text.trim();
                      String description = _descriptionController.text.trim();
                      String extras = _extrasController.text.trim();
                      String tokenName = _tokenNameController.text.trim();
                      String tokenSymbol = _tokenSymbolController.text.trim();
                      String tokenFunctionality = _tokenFunctionalityController.text.trim();

                      String aiPrompt = Prompts.createProjectTokenPrompt(
                        projectName: projectName,
                        description: description,
                        extras: extras,
                        tokenName: tokenName,
                        tokenSymbol: tokenSymbol,
                        tokenFunctionality: tokenFunctionality,
                      );

                      context.read<MessagesViewModel>().setMessageText(aiPrompt);
                    },
                    child: Image.asset(submitButtonPath, height: 50,)
                  ),
                  SizedBox(width: 10),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Stack(
      children: [
        // Background Image
        Image.asset(
          gradientCardPath,
          height: 120.h, // Ensures it fills the available space
        ),

        // Text Overlay
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center, // Centers text vertically
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Ensures readability
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTokenCreationForm() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Project Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          _buildTextField("Project Name", _projectNameController),
          _buildTextField("Description", _descriptionController),
          _buildTextField("Extras", _extrasController),

          SizedBox(height: 16),

          Text("Token Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          _buildTextField("Token Name", _tokenNameController),
          _buildTextField("Token Symbol", _tokenSymbolController),
          _buildTextField("Token Functionality", _tokenFunctionalityController),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        cursorColor: ColorPalette.primaryVariant,
        style: TextStyle(color: Colors.white), // Text color inside the field
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontWeight: FontWeight.bold,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners
            borderSide: BorderSide(color: ColorPalette.primaryVariant, width: 1), // Border color
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: ColorPalette.primaryVariant, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: ColorPalette.primaryVariant, width: 1), // Focused border
          ),
        ),
      ),
    );
  }
}
