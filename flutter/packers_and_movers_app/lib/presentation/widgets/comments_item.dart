import 'package:flutter/material.dart';

class Comment {
  final String username;
  final String comment;
  final String userAviUrl;

  Comment(this.username, this.comment, this.userAviUrl);
}

class CommentItem extends StatelessWidget {
  final String username;
  final String comment;
  final String userAviUrl;

  const CommentItem(
      {super.key,
      required this.username,
      required this.comment,
      required this.userAviUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(userAviUrl),
            radius: 18.0,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(comment),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
