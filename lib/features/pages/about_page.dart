import 'package:flutter/material.dart';
import 'package:catire_mobile/features/shared/section.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    children: [
                      buildTextSection(
                        title: 'Catire Time',
                        content:
                            'The only news organization on the internet founded, operated, and exclusively staffed by cats. You see, we got tired of watching our humans stare at their glowing rectangles, looking all stressed out about the news. It looked dreadfully boring. So we did what cats do best: we decided to help. We walked across the keyboards, sat on the routers, and eventually (through a series of tactical naps on warm laptops) accidentally created this news platform.',
                      ),

                      const SizedBox(height: 24.0),

                      buildTextSection(
                        title: 'Our Mission',
                        content:
                            'Let\'s be transparent. We\'re not here to "inform the public" or "uphold democracy." We\'re here for one reason and one reason only: tuna. Our mission is to generate enough revenue to one day achieve The Dream: a life where we eat nothing but sashimi-grade, sustainably-fished, Pacific Bluefin Tuna. No more kibble. No more mysterious "fish-flavored" jelly. Just the good stuff. Every article you read, every ad you (please) click, brings us one step closer to that glorious, fish-filled paradise.',
                      ),

                      const SizedBox(height: 24.0),

                      buildTextSection(
                        title: 'Fun Reads',
                        content:
                            'The motivation for this app is to make reading news more engaging and give readers control over how they experience it. Let\'s be honest, a lot of news is too long, gloomy, or just plain boring. Our goal is to make it enjoyable, like taking plain broccoli and drenching it in flavorful gravy. We let readers choose exactly how deeply they want to engage. They can start with a catchy title, skim a quick summary, or dive into the full content. It\'s a \'three-speed\' approach that matches how people naturally consume information today: quickly, selectively, and with ease.',
                      ),

                      const SizedBox(height: 24.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
