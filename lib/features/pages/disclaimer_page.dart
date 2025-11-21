import 'package:flutter/material.dart';

import '../shared/section.dart';

class DisclaimerPage extends StatelessWidget {
  const DisclaimerPage({super.key});

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
                        content:
                            'All content on Catire Time is for entertainment purposes only. This is a satire website.',
                      ),

                      const SizedBox(height: 24.0),

                      buildTextSection(
                        content:
                            'The articles on this site are satirical works based on real current events. While inspired by actual news, the stories presented are heavily fictionalized, exaggerated, and infused with humor, puns, and satire. They are not to be taken as factual news reports.',
                      ),

                      const SizedBox(height: 24.0),

                      buildTextSection(
                        content:
                            'Much of our content is generated with the assistance of artificial intelligence (AI), which combines real-world events with absurdity and humor.',
                      ),

                      const SizedBox(height: 24.0),

                      buildTextSection(
                        content:
                            'Names, characters, businesses, places, events, and incidents are either drawn from the original source, entirely fictional, or presented with satirical intent. Any resemblance to actual persons, living or dead, or actual events is purely coincidental and is not intended to be defamatory or malicious.',
                      ),

                      const SizedBox(height: 24.0),

                      buildTextSection(
                        content:
                            'Catire Time makes no representations or warranties of any kind, express or implied, about the completeness, accuracy, reliability, or suitability of any information on this site. Any reliance you place on such information is therefore strictly at your own risk.',
                      ),

                      const SizedBox(height: 24.0),

                      buildTextSection(
                        content:
                            'For accurate and up-to-date news, please consult reputable news organizations. Catire Time is not for factual information.',
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
