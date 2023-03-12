import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      width: mediaQuery.size.width,
      margin: const EdgeInsets.symmetric( horizontal: 12.0, vertical: 12.0, ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),

          // Heading
          SizedBox(
            width: mediaQuery.size.width * 0.5,
            child: const Text(
              "Discover Your Favorite Job",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          const SizedBox(
            height: 25,
          ),

          // Search bar
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(15.0,),
            ),
            margin: const EdgeInsets.symmetric( vertical: 12.0, ),
            padding: const EdgeInsets.symmetric( vertical: 10.0, horizontal: 8.0, ),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric( horizontal: 8.0, ),
                  child: const Icon(
                    Icons.search_sharp,
                  ),
                ),
                const Text("Search Job or Company"),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: const Icon(
                      Icons.filter_list_rounded,
                    ),
                  ),
                )
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.only( top: 12.0, ),
            width: mediaQuery.size.width * 0.5,
            child: const Text(
              "Popular Jobs",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          SizedBox(
            width: mediaQuery.size.width,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric( horizontal: 8.0, ),
                    padding: const EdgeInsets.all( 20.0, ),
                    decoration: BoxDecoration(
                      color: const Color(0xff343434),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: mediaQuery.size.width * 0.8,
                    height: 190,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // Icon
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/img4.png"
                                  )
                                ),
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              width: 60,
                              height: 60,
                            ),

                            // company name
                            Container(
                              height: 40,
                              margin: const EdgeInsets.symmetric( horizontal: 12.0, ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Amazon",
                                    style: TextStyle(
                                      color: Color(0xff626262)
                                    ),
                                  ),
                                  Text(
                                    "Product Designer",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Favourite
                            Expanded(
                              child: Container(
                                height: 50,
                                alignment: Alignment.topRight,
                                child: const Icon(
                                  Icons.favorite_border,
                                  color: Color(0xff626262),
                                  size: 30,
                                ),
                              ),
                            )
                          ],
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        Row(
                          children: const [
                            Icon(
                              Icons.location_on_outlined,
                              color: Color(0xff6c6c6c),
                              size: 30,
                            ),

                            Text(
                              "Washington, United States",
                              style: TextStyle(
                                color: Color(0xff6c6c6c),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xff474747),
                              ),
                              padding: const EdgeInsets.symmetric( vertical: 8.0, horizontal: 12.0, ),
                              child: const Text(
                                "Freelance",
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                            ),

                            const SizedBox(
                              width: 10,
                            ),

                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xff474747),
                              ),
                              padding: const EdgeInsets.symmetric( vertical: 8.0, horizontal: 12.0, ),
                              child: const Text(
                                "Full time",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ),

                  // netflix
                  Container(
                      margin: const EdgeInsets.symmetric( horizontal: 8.0, ),
                      padding: const EdgeInsets.all( 20.0, ),
                      decoration: BoxDecoration(
                        color: const Color(0xff343434),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: mediaQuery.size.width * 0.8,
                      height: 190,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Icon
                              Container(
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/img6.jpg"
                                      )
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                width: 60,
                                height: 60,
                              ),

                              // company name
                              Container(
                                height: 40,
                                margin: const EdgeInsets.symmetric( horizontal: 12.0, ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      "Netflix",
                                      style: TextStyle(
                                          color: Color(0xff626262)
                                      ),
                                    ),
                                    Text(
                                      "UI/UX Designer",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Favourite
                              Expanded(
                                child: Container(
                                  height: 50,
                                  alignment: Alignment.topRight,
                                  child: const Icon(
                                    Icons.favorite_border,
                                    color: Color(0xff626262),
                                    size: 30,
                                  ),
                                ),
                              )
                            ],
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          Row(
                            children: const [
                              Icon(
                                Icons.location_on_outlined,
                                color: Color(0xff6c6c6c),
                                size: 30,
                              ),

                              Text(
                                "Kentukky, Canada",
                                style: TextStyle(
                                  color: Color(0xff6c6c6c),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xff474747),
                                ),
                                padding: const EdgeInsets.symmetric( vertical: 8.0, horizontal: 12.0, ),
                                child: const Text(
                                  "Remote",
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),

                              const SizedBox(
                                width: 10,
                              ),

                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xff474747),
                                ),
                                padding: const EdgeInsets.symmetric( vertical: 8.0, horizontal: 12.0, ),
                                child: const Text(
                                  "Flexible Hours",
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                  ),

                  Container(
                      margin: const EdgeInsets.symmetric( horizontal: 8.0, ),
                      padding: const EdgeInsets.all( 20.0, ),
                      decoration: BoxDecoration(
                        color: const Color(0xff343434),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: mediaQuery.size.width * 0.8,
                      height: 190,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Icon
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/img5.jpg"
                                      )
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                width: 60,
                                height: 60,
                              ),

                              // company name
                              Container(
                                height: 40,
                                margin: const EdgeInsets.symmetric( horizontal: 12.0, ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      "Microsoft",
                                      style: TextStyle(
                                          color: Color(0xff626262)
                                      ),
                                    ),
                                    Text(
                                      "Product Designer",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Favourite
                              Expanded(
                                child: Container(
                                  height: 50,
                                  alignment: Alignment.topRight,
                                  child: const Icon(
                                    Icons.favorite_border,
                                    color: Color(0xff626262),
                                    size: 30,
                                  ),
                                ),
                              )
                            ],
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          Row(
                            children: const [
                              Icon(
                                Icons.location_on_outlined,
                                color: Color(0xff6c6c6c),
                                size: 30,
                              ),

                              Text(
                                "Washington, United States",
                                style: TextStyle(
                                  color: Color(0xff6c6c6c),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xff474747),
                                ),
                                padding: const EdgeInsets.symmetric( vertical: 8.0, horizontal: 12.0, ),
                                child: const Text(
                                  "Freelance",
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),

                              const SizedBox(
                                width: 10,
                              ),

                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xff474747),
                                ),
                                padding: const EdgeInsets.symmetric( vertical: 8.0, horizontal: 12.0, ),
                                child: const Text(
                                  "Full time",
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          Container(
            margin: const EdgeInsets.only( top: 12.0, ),
            width: mediaQuery.size.width * 0.5,
            child: const Text(
              "Recent Jobs",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),

          const SizedBox(
            height: 25,
          ),

          // Google
          Container(
            width: mediaQuery.size.width,
            margin: const EdgeInsets.symmetric(horizontal: 16.0, ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only( right: 16.0, ),
                  width: 50,
                  height: 50,
                  child: Image.asset("assets/images/google.png")
                ),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric( vertical: 2.0, ),
                        child: const Text("Google"),
                      ),
                      const Text(
                        "UI Designer",
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),

                const Icon(
                  Icons.favorite_border
                )
              ],
            ),
          ),

          const SizedBox(
            height: 25,
          ),

          // Apple
          Container(
            width: mediaQuery.size.width,
            margin: const EdgeInsets.symmetric(horizontal: 16.0, ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: const EdgeInsets.only( right: 16.0, ),
                    width: 50,
                    height: 50,
                    child: Image.asset("assets/images/apple.png")
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric( vertical: 2.0, ),
                        child: Text("Apple"),
                      ),
                      Text(
                        "System Engineer",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),

                Icon(
                    Icons.favorite_border
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
