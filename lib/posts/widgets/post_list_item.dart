import 'package:flutter/material.dart';
import 'package:test3/posts/posts.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({required this.post, super.key});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      color: Colors.grey.shade200,
      child: ListTile(
        leading: Text('${post.id}', style: textTheme.bodyMedium, textAlign: TextAlign.center,),
        title: Text(post.title, style: textTheme.titleMedium, textAlign: TextAlign.justify,),
        isThreeLine: true,
        subtitle: Text(post.body, style:textTheme.bodySmall, textAlign: TextAlign.justify,),
        dense: true,
      ),
    );
  }
}

