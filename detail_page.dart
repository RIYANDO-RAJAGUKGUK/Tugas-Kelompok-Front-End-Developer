import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/groceries_data.dart';
import 'package:flutter_application_1/cart.dart';
import 'package:flutter_application_1/profile_provider.dart';
import 'package:flutter_application_1/theme.dart';
import 'package:provider/provider.dart';
import 'package:gap/gap.dart';
import 'package:readmore/readmore.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart'; 
import 'package:share/share.dart';

class Comment {
  final String text;
  final String username;
  final String profilePicture;

  Comment({
    required this.text,
    required this.username,
    required this.profilePicture,
  });
}

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.groceries}) : super(key: key);
  final Groceries groceries;
  

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity = 1;
  TextEditingController _commentController = TextEditingController();
  List<Comment> comments = [];
  bool _isSaved = false; 

  Map<String, List<String>> carouselImagesMap = {
    'jeruk': [
      'assets/jeruk.png',
      'assets/jeruk1.png',
      'assets/jeruk2.png',
      'assets/jeruk3.png',
    ],
    'apel': [
      'assets/apel.png',
      'assets/apel1.png',
      'assets/apel2.png',
      'assets/apel3.png',
    ],
    'alpukat': [
      'assets/alpukat.png',
      'assets/alpukat1.png',
      'assets/alpukat2.png',
      'assets/alpukat3.png',
    ],
    'pisang': [
      'assets/pisang.png',
      'assets/pisang1.png',
      'assets/pisang2.png',
      'assets/pisang3.png',
    ],
    'jagung': [
      'assets/jagung.png',
      'assets/jagung1.png',
      'assets/jagung2.png',
      'assets/jagung3.png',
    ],
    'manggis': [
      'assets/manggis.png',
      'assets/manggis1.png',
      'assets/manggis2.png',
      'assets/manggis3.png',
    ],
  };
  String generateRandomUsername() {
    const adjectives = [
      'Susi',
      'Anto',
      'Jaya',
      'Bara',
      'Ucu',
      'Lina',
      'Kim',
      'Kara',
      'Suja',
      'Meli'
    ];
    const nouns = [
      'Ai',
      'Seja',
      'Miu',
      'Langsa',
      'Pira',
      'Joda',
      'Sako',
      'Nia',
      'Jaga',
      'Pisa'
    ];
    final random = Random();
    final adjective = adjectives[random.nextInt(adjectives.length)];
    final noun = nouns[random.nextInt(nouns.length)];
    return '$adjective$noun';
  }

  String generateRandomProfilePicture() {
    final random = Random();
    final randomNumber = random.nextInt(100); 
    return 'https://picsum.photos/200/300?random=$randomNumber';
  }

  void _showCommentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (comments.isNotEmpty) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Comments',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: comments.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _buildCommentWidget(comments[index]);
                        },
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ],
                TextField(
                  controller: _commentController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Write your comment...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          String commentText = _commentController.text;
                          if (commentText.isNotEmpty) {
                            String randomUsername = generateRandomUsername();
                            String randomProfilePicture = generateRandomProfilePicture();
                            Comment newComment = Comment(
                              text: commentText,
                              username: randomUsername,
                              profilePicture: randomProfilePicture,
                            );
                            comments.insert(0, newComment); 
                            _commentController.clear(); 
                            setState(() {}); 
                            Navigator.pop(context); 
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Comment submitted successfully!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void shareProduct(String productName, String productDescription, String productUrl) {
    Share.share(
      'Check out this product: $productName\n\nDescription: $productDescription\n\n$productUrl',
      subject: 'Check out this product: $productName',
    );
  }

  void toggleSaved() {
    setState(() {
      _isSaved = !_isSaved;
      if (_isSaved) {
        Provider.of<CartProvider>(context, listen: false).addItem(widget.groceries);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product added!'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        Provider.of<ProfileProvider>(context, listen: false).removeFromFavorites(widget.groceries);
        Provider.of<CartProvider>(context, listen: false).removeItem(widget.groceries); 
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product removed!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }


  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? theme.textTheme.bodyMedium?.color ?? Colors.black;
    final iconColor = theme.iconTheme.color;
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.grey[900] : Colors.teal.shade100,

      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const Gap(68),
          buildHeader(context),
          const Gap(24),
          buildImage(), 
          const Gap(20),
          buildMainInfo(textColor),
          const Gap(20),
          buildDescription(textColor),
          const Gap(30),
        ],
      ),
      bottomNavigationBar: buildPrice(textColor, iconColor),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          tooltip: 'Kembali',
        ),
        Expanded(
          child: Center(
            child: Text(
              'Detail',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Theme.of(context).textTheme.headlineSmall?.color,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            shareProduct(widget.groceries.name, widget.groceries.description, 'http://localhost:61620/#detail');
          },
          icon: Icon(Icons.share, color: Theme.of(context).iconTheme.color),
          tooltip: 'Bagikan',
        ),
        IconButton(
          onPressed: toggleSaved,
          icon: Icon(
            _isSaved ? Icons.bookmark : Icons.bookmark_border,
            color: Theme.of(context).iconTheme.color,
          ),
          tooltip: _isSaved ? 'Remove from Favorite' : 'Save to Favorit',
        ),
      ],
    );
  }

  Widget buildImage() {
    List<String> carouselImages = [];
    String productType = determineProductType(widget.groceries.name);

    if (carouselImagesMap.containsKey(productType)) {
      carouselImages.addAll(carouselImagesMap[productType]!);
    } else {
      carouselImages.add(widget.groceries.image);
    }

    return CarouselSlider(
      options: CarouselOptions(
        height: 202,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        viewportFraction: 1.0,
        autoPlay: true, 
        autoPlayInterval: Duration(seconds: 2),
      ),
      items: carouselImages.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                image,
                width: double.infinity,
                height: 202,
                fit: BoxFit.cover,
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget buildMainInfo(Color? textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.groceries.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: textColor,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(4),
                const Gap(16),
                Row(
                  children: [
                    Image.asset(
                      'assets/bintang.png',
                      width: 20,
                      height: 20,
                    ),
                    const Gap(4),
                    Text(
                      '${widget.groceries.rate} ',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: textColor,
                      ),
                    ),
                    Text(
                      '(${widget.groceries.review})',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: textColor?.withOpacity(0.6),
                      ),
                    ),
                    const Gap(8), 
                    GestureDetector(
                      onTap: () {
                        _showCommentBottomSheet(context);
                      },
                      child: Icon(
                        Icons.comment, 
                        color: Colors.grey, 
                        size: 20, 
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const Gap(16),
        const Divider(
          indent: 16,
          endIndent: 16,
          color: Color(0xffE3E3E3),
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }

  Widget buildDescription(Color? textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: textColor,
          ),
        ),
        const Gap(8),
        ReadMoreText(
          widget.groceries.description,
          trimLength: 110,
          trimMode: TrimMode.Length,
          trimCollapsedText: ' Read More',
          trimExpandedText: ' Read Less',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 14,
            color: textColor?.withOpacity(0.6),
          ),
          moreStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Color(0xffC67C4E),
          ),
        ),
      ],
    );
  }

  Widget buildPrice(Color? textColor, Color? iconColor) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.teal.shade50,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Price',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: textColor?.withOpacity(0.6),
                  ),
                ),
                const Gap(4),
                Row(
                  children: [
                    Text(
                      NumberFormat.currency(
                        decimalDigits: 2,
                        locale: 'en_US',
                        symbol: '\$ ',
                      ).format(widget.groceries.price * quantity),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: const Color(0xffC67C4E),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    if (quantity > 1) quantity--;
                  });
                },
                icon: Icon(Icons.remove, color: iconColor),
                tooltip: 'Kurang',
              ),
              Text(
                quantity.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: textColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    quantity++;
                  });
                },
                icon: Icon(Icons.add, color: iconColor),
                tooltip: 'Tambah',
              ),
            ],
          ),
          SizedBox(
            width: 217,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                for (int i = 0; i < quantity; i++) {
                  Provider.of<CartProvider>(context, listen: false)
                      .addItem(widget.groceries);
                }
                Provider.of<ProfileProvider>(context, listen: false)
                    .addOrderToHistory(widget.groceries);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Item successfully added!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text(
                'Buy Now',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildCommentWidget(Comment comment) {
    bool isVerified = shouldShowVerificationIcon(comment.username);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(comment.profilePicture),
            radius: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    if (isVerified) 
                      Icon(
                        Icons.verified,
                        color: Colors.blue,
                        size: 16,
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  comment.text,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool shouldShowVerificationIcon(String username) {
    return username.toLowerCase().contains("admin");
  }

  String determineProductType(String productName) {
    if (productName.toLowerCase().contains('jeruk')) {
      return 'jeruk';
    } else if (productName.toLowerCase().contains('apel')) {
      return 'apel';
    }else if (productName.toLowerCase().contains('alpukat')) {
      return 'alpukat';
    }else if (productName.toLowerCase().contains('pisang')) {
      return 'pisang';
    }else if (productName.toLowerCase().contains('jagung')) {
      return 'jagung';
    }else if (productName.toLowerCase().contains('manggis')) {
      return 'manggis';
    }
    return 'default';
  }
}
