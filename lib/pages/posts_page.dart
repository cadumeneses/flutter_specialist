import 'package:flutter/material.dart';
import 'package:flutter_specialist/model/post_model.dart';
import 'package:flutter_specialist/pages/comentarios_page.dart';
import 'package:flutter_specialist/repositories/post_repository.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  var postsRepository = PostRepository();
  var posts = <PostsModel>[];

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    posts = await postsRepository.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Posts'),
          ),
          body: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (_, index) {
              var post = posts[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  ComentariosPage(postId: post.id)));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.title,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            post.body,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}
