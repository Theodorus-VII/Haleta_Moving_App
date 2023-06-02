import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class NotificationFromMover {
  final double value;
  String? message;

  NotificationFromMover(this.value, {this.message = ''});
}

class Item {
  final String name;
  final String rating;
  final String phone;
  bool expanded;

  Item(this.name, this.rating, this.phone, {this.expanded = false});
}

class ExpandableListItem extends StatefulWidget {
  final Item item;
  final NotificationFromMover noti;

  const ExpandableListItem({Key? key, required this.item, required this.noti})
      : super(key: key);

  @override
  _ExpandableListItemState createState() => _ExpandableListItemState();
}

class _ExpandableListItemState extends State<ExpandableListItem> {
  bool dismissed = false;
  double rating = 0.0;
  String comment = '';

  @override
  Widget build(BuildContext context) {
    if (widget.noti.value < 0 && !dismissed) {
      return Dismissible(
        key: Key(widget.item.name),
        direction: DismissDirection.horizontal,
        onDismissed: (direction) {
          setState(() {
            dismissed = true;
          });
          // Handle the dismissal action here
          // This function will be called when the tile is swiped away
        },
        background: Container(
          color: Colors.red,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
              SizedBox(width: 16.0),
            ],
          ),
        ),
        child: buildCard(),
      );
    } else {
      return buildCard();
    }
  }

  Widget buildCard() {
    return dismissed
        ? Container() // Hide the tile if it's dismissed
        : Container(
            margin: const EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 0.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 2.0,
              child: Column(
                children: [
                  ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8.0),
                        Text(
                          widget.item.name,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5.0),
                        Text(
                          'Rating: ${widget.item.rating}',
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        Text(
                          'Phone: ${widget.item.phone}',
                          style: const TextStyle(fontSize: 14.0),
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        widget.item.expanded = !widget.item.expanded;
                      });
                    },
                    tileColor: Colors.grey[200],
                    dense: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    trailing: widget.item.expanded
                        ? const Icon(Icons.expand_less)
                        : const Icon(Icons.expand_more),
                  ),
                  if (widget.item.expanded)
                    Builder(
                      builder: (context) {
                        if (widget.noti.value < 0) {
                          return Column(
                            children: [
                              const SizedBox(height: 16.0),
                              Container(
                                color: Colors.red,
                                padding: const EdgeInsets.all(8.0),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.swipe,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 8.0),
                                    Text(
                                      'Rejected. Swipe to dismiss',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16.0),
                            ],
                          );
                        }

                        double progressValue = widget.noti.value;

                        Color progressColor;
                        String label;

                        if (progressValue <= 0.25) {
                          progressColor = Colors.red;
                          label = 'Packing started';
                        } else if (progressValue <= 0.5) {
                          progressColor = Colors.orange;
                          label = 'Moving started';
                        } else if (progressValue <= 0.75) {
                          progressColor = Colors.blue;
                          label = 'Halfway on the road';
                        } else {
                          progressColor = Colors.green;
                          label = 'Completed';
                        }

                        return Column(
                          children: [
                            const SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: CircularProgressIndicator(
                                    value: progressValue,
                                    strokeWidth: 8,
                                    backgroundColor: Colors.grey[300],
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        progressColor),
                                  ),
                                ),
                                Text(
                                  label,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            if (progressValue == 1.0) ...[
                              const SizedBox(height: 16.0),
                              Card(
                                elevation: 2.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      RatingBar.builder(
                                        initialRating: rating,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        itemSize: 24.0,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (newRating) {
                                          setState(() {
                                            rating = newRating;
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 16.0),
                                      TextFormField(
                                        decoration: const InputDecoration(
                                          labelText: 'Comment (optional)',
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            comment = value;
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 16.0),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Handle submit action here
                                          // This function will be called when the submit button is pressed
                                          // You can access the rating and comment variables here
                                          print('Rating: $rating');
                                          print('Comment: $comment');
                                        },
                                        child: const Text('Submit'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                            ],
                            const SizedBox(height: 16.0),
                          ],
                        );
                      },
                    ),
                ],
              ),
            ),
          );
  }
}
