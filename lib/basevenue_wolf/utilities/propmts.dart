class Prompts {
  static String createProjectTokenPrompt({
    required String projectName,
    required String description,
    required String extras,
    required String tokenName,
    required String tokenSymbol,
    required String tokenFunctionality,
  }) {
    return """
    I am creating a token for my project: **$projectName**.
    
    **Project Description:** $description
    
    **Additional Info:** $extras
    
    **Token Details:**
    - **Token Name:** $tokenName
    - **Token Symbol:** $tokenSymbol
    - **Functionality:** $tokenFunctionality
    
    Please generate tokenomics and suggestions for the best way to use this token in my project.
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
    I am creating an ERC20 token for my game project: **$projectName**.

    **Project Description:** $description

    **Token Details:**
    - **Token Name:** $tokenName
    - **Token Symbol:** $tokenSymbol
    - **Functionality:** $tokenFunctionality
    - **Price Ratio to Main Token:** $priceRatio

    Please generate tokenomics and suggest the best way to use this token in my game economy.
    """;
  }

  /// Prompt for creating a Game Item (NFT)
  static String createGameItemPrompt({
    required String projectName,
    required String description,
    required String nftName,
    required String nftFunctionality,
    required String priceRatio,
  }) {
    return """
    I am creating an NFT for my game project: **$projectName**.

    **Project Description:** $description

    **NFT Details:**
    - **NFT Name:** $nftName
    - **Functionality:** $nftFunctionality
    - **Price Ratio to Main Token:** $priceRatio

    Please generate use-case ideas and suggest the best way to integrate this NFT into my game.
    """;
  }

}
