class Queries {
  static const getPostsWithComments = '*,comments(*)';
  static const getUserWithPostsAndComments =
      '*, posts: posts_gpt(*, comments : comments_gpt(*))';
}
