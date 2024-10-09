module my_addrx::LostAndFoundRegistry {
    use std::coin::{transfer};
    use std::aptos_coin::AptosCoin;
    use std::signer;
    use std::string::String;
    use std::vector;
    
    const ERR_ITEM_NOT_FOUND: u64 = 1;
    const ERR_ITEM_ALREADY_CLAIMED: u64 = 2;
    const ERR_NOT_OWNER: u64 = 3;
    const ERR_NOT_FINDER: u64 = 4;
    const ERR_NO_ACTIVE_ITEMS: u64 = 5;
    const ERR_ALREADY_VERIFIED: u64 = 6;
    const ERR_ALREADY_INITIALIZED: u64 = 7;
    
    const Global_Registry_Address: address = @sys_addrx;

    // Struct representing each finder's submission for an item
    struct FinderSubmission has key, store, copy, drop {
        finder: address,
        description: String,
        is_verified: bool, // Tracks if the finder has been verified
    }

    // Struct representing a lost item
    struct LostItem has key, store, copy, drop {
        unique_id: u64,
        owner: address,
        reward: u64,
        title: String,
        description: String,
        is_claimed: bool,  // Tracks if the item has been claimed by a verified finder
        finders: vector<FinderSubmission>, // List of all finders who claim to have found the item
    }

    // Struct representing the global registry of lost items
    struct ItemRegistry has key, store, copy, drop {
        items: vector<LostItem>,
        last_item_id: u64,  // Tracks the last used unique item ID
    }

    // Initialize the registry (only called once)
    public entry fun init_registry(account: &signer) {
        let global_address = Global_Registry_Address;

        // Ensure the registry hasn't already been initialized
        if (exists<ItemRegistry>(global_address)) {
            abort(ERR_ALREADY_INITIALIZED)
        };

        // Initialize the item registry and move it to the global address
        let registry = ItemRegistry {
            items: vector::empty<LostItem>(),
            last_item_id: 1000,
        };
        move_to(account, registry);
    }

    // Owner registers a lost item (no funds transferred at this point)
    public entry fun register_lost_item(
        account: &signer,
        title: String,
        description: String,
        reward: u64
    ) acquires ItemRegistry {
        let owner_address = signer::address_of(account);
        let global_address = Global_Registry_Address;

        // Ensure the registry exists
        assert!(exists<ItemRegistry>(global_address), ERR_NO_ACTIVE_ITEMS);

        let registry_ref = borrow_global_mut<ItemRegistry>(global_address);

        // Generate a unique item ID for the new lost item
        let unique_id = registry_ref.last_item_id + 1;
        registry_ref.last_item_id = unique_id;

        // Create the new lost item and store it
        let new_item = LostItem {
            unique_id: unique_id,
            owner: owner_address,
            reward: reward,
            title: title,
            description: description,
            is_claimed: false,
            finders: vector::empty<FinderSubmission>(),
        };
        vector::push_back(&mut registry_ref.items, new_item);
    }

    // Finder registers a found item
    public entry fun register_found_item(
        account: &signer,
        unique_id: u64,
        description: String
    ) acquires ItemRegistry {
        let finder_address = signer::address_of(account);
        let global_address = Global_Registry_Address;

        // Ensure the registry exists
        assert!(exists<ItemRegistry>(global_address), ERR_NO_ACTIVE_ITEMS);

        let registry_ref = borrow_global_mut<ItemRegistry>(global_address);

        // Find the item by unique ID
        let items_len = vector::length(&registry_ref.items);
        let i = 0;
        while (i < items_len) {
            let item_ref = vector::borrow_mut(&mut registry_ref.items, i);
            if (item_ref.unique_id == unique_id) {
                assert!(!item_ref.is_claimed, ERR_ITEM_ALREADY_CLAIMED);

                // Register the finder submission
                let new_finder_submission = FinderSubmission {
                    finder: finder_address,
                    description: description,
                    is_verified: false,
                };
                vector::push_back(&mut item_ref.finders, new_finder_submission);
                return
            };
            i = i + 1;
        };
        abort(ERR_ITEM_NOT_FOUND)
    }

    // Owner verifies that a specific finder has found their item and transfers the reward
    public entry fun verify_finder(
        account: &signer,
        unique_id: u64,
        finder_address: address
    ) acquires ItemRegistry {
        let owner_address = signer::address_of(account);
        let global_address = Global_Registry_Address;

        // Ensure the registry exists
        assert!(exists<ItemRegistry>(global_address), ERR_NO_ACTIVE_ITEMS);

        let registry_ref = borrow_global_mut<ItemRegistry>(global_address);

        // Find the item by unique ID
        let items_len = vector::length(&registry_ref.items);
        let i = 0;
        while (i < items_len) {
            let item_ref = vector::borrow_mut(&mut registry_ref.items, i);
            if (item_ref.unique_id == unique_id) {
                // Ensure only the owner can verify the finder
                assert!(item_ref.owner == owner_address, ERR_NOT_OWNER);

                // Loop through the list of finders and verify the matching one
                let finders_len = vector::length(&item_ref.finders);
                let j = 0;
                while (j < finders_len) {
                    let finder_ref = vector::borrow_mut(&mut item_ref.finders, j);
                    if (finder_ref.finder == finder_address) {
                        assert!(!finder_ref.is_verified, ERR_ALREADY_VERIFIED);

                        // Mark the finder as verified
                        finder_ref.is_verified = true;

                        // Transfer the reward from the owner to the verified finder
                        transfer<AptosCoin>(account, finder_address, item_ref.reward);

                        // Mark the item as claimed and close the process
                        item_ref.is_claimed = true;
                        return
                    };
                    j = j + 1;
                };
                abort(ERR_NOT_FINDER)
            };
            i = i + 1;
        };
        abort(ERR_ITEM_NOT_FOUND)
    }

    // View all lost items currently registered
    #[view]
    public fun view_all_items(): vector<LostItem> acquires ItemRegistry {
        let global_address = Global_Registry_Address;

        // Ensure the registry exists
        assert!(exists<ItemRegistry>(global_address), ERR_NO_ACTIVE_ITEMS);

        let registry_ref = borrow_global<ItemRegistry>(global_address);
        registry_ref.items
    }

    // View specific item by unique ID
    #[view]
    public fun view_item_by_id(unique_id: u64): LostItem acquires ItemRegistry {
        let global_address = Global_Registry_Address;

        // Ensure the registry exists
        assert!(exists<ItemRegistry>(global_address), ERR_NO_ACTIVE_ITEMS);

        let registry_ref = borrow_global<ItemRegistry>(global_address);

        let items_len = vector::length(&registry_ref.items);
        let i = 0;
        while (i < items_len) {
            let item_ref = vector::borrow(&registry_ref.items, i);
            if (item_ref.unique_id == unique_id) {
                return *item_ref
            };
            i = i + 1;
        };
        abort(ERR_ITEM_NOT_FOUND)
    }

    // View all finders who registered for a specific item
    #[view]
    public fun view_finders_by_item(unique_id: u64): vector<FinderSubmission> acquires ItemRegistry {
        let global_address = Global_Registry_Address;

        // Ensure the registry exists
        assert!(exists<ItemRegistry>(global_address), ERR_NO_ACTIVE_ITEMS);

        let registry_ref = borrow_global<ItemRegistry>(global_address);

        let items_len = vector::length(&registry_ref.items);
        let i = 0;
        while (i < items_len) {
            let item_ref = vector::borrow(&registry_ref.items, i);
            if (item_ref.unique_id == unique_id) {
                return item_ref.finders
            };
            i = i + 1;
        };
        abort(ERR_ITEM_NOT_FOUND)
    }

        // View all items registered by a specific owner
    #[view]
    public fun view_items_by_owner(owner: address): vector<LostItem> acquires ItemRegistry {
        let global_address = Global_Registry_Address;

        // Ensure the registry exists
        assert!(exists<ItemRegistry>(global_address), ERR_NO_ACTIVE_ITEMS);

        let registry_ref = borrow_global<ItemRegistry>(global_address);
        let result = vector::empty<LostItem>();

        let items_len = vector::length(&registry_ref.items);
        let i = 0;
        while (i < items_len) {
            let item_ref = vector::borrow(&registry_ref.items, i);
            if (item_ref.owner == owner) {
                vector::push_back(&mut result, *item_ref);
            };
            i = i + 1;
        };
        result
    }

    // View all items that were found by a specific finder
    #[view]
    public fun view_items_found_by_finder(finder: address): vector<LostItem> acquires ItemRegistry {
        let global_address = Global_Registry_Address;

        // Ensure the registry exists
        assert!(exists<ItemRegistry>(global_address), ERR_NO_ACTIVE_ITEMS);

        let registry_ref = borrow_global<ItemRegistry>(global_address);
        let result = vector::empty<LostItem>();

        let items_len = vector::length(&registry_ref.items);
        let i = 0;
        while (i < items_len) {
            let item_ref = vector::borrow(&registry_ref.items, i);
            let finders_len = vector::length(&item_ref.finders);
            let j = 0;
            while (j < finders_len) {
                let finder_ref = vector::borrow(&item_ref.finders, j);
                if (finder_ref.finder == finder) {
                    vector::push_back(&mut result, *item_ref);
                    break
                };
                j = j + 1;
            };
            i = i + 1;
        };
        result
    }
}
