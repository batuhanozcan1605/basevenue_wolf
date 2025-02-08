class Prompts {

  static String createProjectTokenPrompt({
    required String projectName,
    required String description,
    required String extras,
    required String tokenName,
    required String tokenSymbol,
    required String tokenFunctionality,
  }) {
    String additionalInfo(extras) {
      if(extras != '') {
        return  "Additional Info: $extras";
      } else if(extras == '') {
        return "" ;
      }  else {
        return "";
    }
    }

      return """
    Create token design for my game: $projectName with features below:
    
    Project Description: $description
    
    Token Details:
    - Token Name: $tokenName
    - Token Symbol: $tokenSymbol
    - Functionality: $tokenFunctionality
    
    ${additionalInfo(extras)}
    """;
    }

  /// Prompt for creating a Game Product (ERC20 Token)
  static String createGameProductPrompt({
    required String projectName,
    required String description,
    required String tokenName,
    required String tokenSymbol,
    required String tokenFunctionality,
    required String priceRatio,

  }) {
    return """
    Create product token for my game: **$projectName**.

    **Project Description:** $description

    **Token Details:**
    - **Token Name:** $tokenName
    - **Token Symbol:** $tokenSymbol
    - **Functionality:** $tokenFunctionality
    - **Price Ratio to Main Token:** $priceRatio
    """;
  }

  /// Prompt for creating a Game Item (NFT)
  static String createGameItemPrompt({
    required String projectName,
    required String description,
    required String nftName,
    required String nftFunctionality,
    required String priceRatio,
    required String nftUri
  }) {
    return """
    Create Item NFT for my game: **$projectName**.

    **Project Description:** $description

    **NFT Details:**
    - **NFT Name:** $nftName
    - **Functionality:** $nftFunctionality
    - **Price Ratio to Main Token:** $priceRatio
    - **NFT Image Uri Link:** $nftUri
    """;
  }

}
