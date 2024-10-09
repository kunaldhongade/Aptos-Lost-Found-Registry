import Placeholder1 from "@/assets/placeholders/bear-1.png";
import Placeholder2 from "@/assets/placeholders/bear-2.png";
import Placeholder3 from "@/assets/placeholders/bear-3.png";

export const config: Config = {
  // Removing one or all of these socials will remove them from the page
  socials: {
    twitter: "https://twitter.com/kunaldhongade",
    discord: "https://discord.com",
    homepage: "https://kunaldhongade.vercel.app",
  },

  defaultCollection: {
    name: "Lost & Found Collection",
    description: "A unique collection of lost and found items, each with its own story and history.",
    image: Placeholder1,
  },

  ourStory: {
    title: "Our Story",
    subTitle: "Innovative Lost Item Registry on Aptos",
    description:
      "Our platform offers a secure and transparent way to register and claim lost items. Join our community to help reunite lost items with their rightful owners!",
    discordLink: "https://discord.com",
    images: [Placeholder1, Placeholder2, Placeholder3],
  },

  ourTeam: {
    title: "Our Team",
    members: [
      {
        name: "Kunal",
        role: "Blockchain Developer",
        img: Placeholder1,
        socials: {
          twitter: "https://twitter.com/kunaldhongade",
        },
      },
      {
        name: "Soham",
        role: "Marketing Specialist",
        img: Placeholder2,
      },
      {
        name: "Amrita",
        role: "Community Manager",
        img: Placeholder3,
        socials: {
          twitter: "https://twitter.com",
        },
      },
    ],
  },

  faqs: {
    title: "F.A.Q.",

    questions: [
      {
        title: "How does the Lost & Found system work?",
        description:
          "Our system allows users to register lost items and search for found items. If a match is found, the system facilitates communication between the finder and the owner.",
      },
      {
        title: "How do I register a lost item?",
        description: `To register a lost item, follow these steps:
        Navigate to the "Register Lost Item" section in the app.
        Fill in the required details about the item.
        Submit the registration form.
        Your item will be added to our database of lost items.`,
      },
      {
        title: "How do I search for a found item?",
        description:
          "To search for a found item, navigate to the 'Search Found Items' section in the app. You can filter the search results based on various criteria such as item type, location, and date found.",
      },
      {
        title: "What should I do if I find a lost item?",
        description: `If you find a lost item, follow these steps:
        Navigate to the "Report Found Item" section in the app.
        Provide the necessary details about the item.
        Submit the report.
        Our system will try to match the item with any registered lost items.`,
      },
      {
        title: "How can I contact the owner of a found item?",
        description: `If a match is found between a lost item and a found item, our system will facilitate communication between the finder and the owner through a secure messaging platform.`,
      },
      {
        title: "Is there a reward for finding a lost item?",
        description: `Yes, our platform offers a reward system for finders of lost items. The reward details will be provided by the owner of the lost item during the registration process.`,
      },
    ],
  },

  nftBanner: [Placeholder1, Placeholder2, Placeholder3],
};

export interface Config {
  socials?: {
    twitter?: string;
    discord?: string;
    homepage?: string;
  };

  defaultCollection?: {
    name: string;
    description: string;
    image: string;
  };

  ourTeam?: {
    title: string;
    members: Array<ConfigTeamMember>;
  };

  ourStory?: {
    title: string;
    subTitle: string;
    description: string;
    discordLink: string;
    images?: Array<string>;
  };

  faqs?: {
    title: string;
    questions: Array<{
      title: string;
      description: string;
    }>;
  };

  nftBanner?: Array<string>;
}

export interface ConfigTeamMember {
  name: string;
  role: string;
  img: string;
  socials?: {
    twitter?: string;
    discord?: string;
  };
}
