import 'package:flutter/material.dart';
import 'package:flutter_gram/utils/constants.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                      "https://th.bing.com/th/id/OIP.GlIuUj-GYrRL_G8WvZ3YagHaHw?w=189&h=197&c=7&r=0&o=5&dpr=1.3&pid=1.7"),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'user name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                child: ListView(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    shrinkWrap: true,
                                    children: ["Hide"]
                                        .map((e) => InkWell(
                                              onTap: () {},
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                        horizontal: 16),
                                                child: Text(e),
                                              ),
                                            ))
                                        .toList()),
                              ));
                    },
                    icon: const Icon(Icons.more_vert))
              ],
            ),
          ),
          //title section
          const Text(
            'Things you have to do in a week',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          //Thumbnail section
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: size.height * 0.25,
              child: Image.network(
                'https://th.bing.com/th/id/OIP.JdQ7ybEMD4BD9HRA4MHl3gHaD8?pid=ImgDet&rs=1',
                fit: BoxFit.cover,
              ),
            ),
          ),

          //upvote,comment section
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Row(
              children: [
                SizedBox(
                  width: size.width * 0.05,
                ),
                const Icon(
                  Icons.arrow_circle_up_sharp,
                  size: 25,
                ),
                const Text('125'),
                kwidth15,
                const Icon(Icons.comment_outlined),
                const Text('125'),
                kwidth15,
                const Icon(Icons.share_outlined),
                const Expanded(
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: Icon(Icons.bookmark_border)))
              ],
            ),
          )
        ],
      ),
    );
  }
}
