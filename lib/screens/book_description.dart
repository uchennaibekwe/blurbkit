import 'package:blurbkit/models/book.dart';
import 'package:blurbkit/providers/audio.dart';
import 'package:blurbkit/widgets/forms.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDescriptionPage extends StatefulWidget {
  final Book book;
  BookDescriptionPage({ this.book });
  @override
  _BookDescriptionPageState createState() => _BookDescriptionPageState();
}

class _BookDescriptionPageState extends State<BookDescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.grey[100],
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              // height: 230,
              child: Card(
                clipBehavior: Clip.hardEdge,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Image(
                  image: NetworkImage('${widget.book.thumbnail}'),
                  // image: AssetImage('images/books/the_book_title.jpg'),
                  height: 230,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 220,
              child: Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.timer),
                      bolderTextStyle('${widget.book.audioTime} mins'),
                      SizedBox(
                        width: 15,
                      ),
                      Icon(Icons.format_list_bulleted),
                      bolderTextStyle(' ${widget.book.noOfPages} pages'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  bolderTextStyle('${widget.book.title.toUpperCase()}', fontSize: 18.0),
                  SizedBox(
                    height: 3,
                  ),
                  bolderTextStyle('${widget.book.author ?? 'Anonymous'}', fontSize: 16.0),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${widget.book.description}',
                    // 'Lorem Ipsum is the ipsum of lorem that virtually no one knows about. Let me explain: They all live happily ever after they lived after.',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  bolderTextStyle('Content', fontSize: 16.0),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${widget.book.contents.isEmpty ? '' : widget.book.contents[0].content}',
                    // 'Lorem Ipsum is the ipsum of lorem that virtually no one knows about. Let me explain: They all live happily ever after they lived after. Lorem Ipsum is the ipsum of lorem that virtually no one knows about. Let me explain: They all live happily ever after they lived after. Lorem Ipsum is the ipsum of lorem that virtually no one knows about. Let me explain: They all live happily ever after they lived after. Lorem Ipsum is the ipsum of lorem that virtually no one knows about. Let me explain: They all live happily ever after they lived after. Lorem Ipsum is the ipsum of lorem that virtually no one knows about. Let me explain: They all live happily ever after they lived after. Lorem Ipsum is the ipsum of lorem that virtually no one knows about. Let me explain: They all live happily ever after they lived after. Lorem Ipsum is the ipsum of lorem that virtually no one knows about. Let me explain: They all live happily ever after they lived after. Lorem Ipsum is the ipsum of lorem that virtually no one knows about. Let me explain: They all live happily ever after they lived after. Lorem Ipsum is the ipsum of lorem that virtually no one knows about. Let me explain: They all live happily ever after they lived after. \n\nLorem Ipsum is the ipsum of lorem that virtually no one knows about. Let me explain: They all live happily ever after they lived after. Lorem Ipsum is the ipsum of lorem that virtually no one knows about. Let me explain: They all live happily ever after they lived after. Lorem Ipsum is the ipsum of lorem that virtually no one knows about. Let me explain: They all live happily ever after they lived after. Lorem Ipsum is the ipsum of lorem that virtually no one knows about. Let me explain: They all live happily ever after they lived after. Lorem Ipsum is the ipsum of lorem that virtually no one knows about. Let me explain: They all live happily ever after they lived after. Lorem Ipsum is the ipsum of lorem that virtually no one knows about. Let me explain: They all live happily ever after they lived after. ',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 55,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18),
          height: 50,
          width: double.infinity,
          child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Play Book',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // load the audio
                      context.read<PlayingModel>().setAudioUrl('https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3');
                      Navigator.pushNamed(context, '/playbook', arguments: widget.book);
                    }),
              ),
              VerticalDivider(
                color: Colors.white,
              ),
              Expanded(
                child: GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.receipt,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Read Book',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/readbook', arguments: widget.book);
                  },
                ),
              ),
            ],
          ),
          color: appColor(),
        ),
      ),
    );
  }
}
