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
}
