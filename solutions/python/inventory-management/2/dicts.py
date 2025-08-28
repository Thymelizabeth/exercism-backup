"""Functions to keep track and alter inventory."""
from functools import reduce

def create_inventory(items):
    """Create a dict that tracks the amount (count) of each element on the `items` list.

    :param items: list - list of items to create an inventory from.
    :return: dict - the inventory dictionary.
    """

    return reduce(lambda acc, x: acc | {x: acc[x] + 1} if x in acc else acc | {x: 1}, items, {})


def add_items(inventory, items):
    """Add or increment items in inventory using elements from the items `list`.

    :param inventory: dict - dictionary of existing inventory.
    :param items: list - list of items to update the inventory with.
    :return: dict - the inventory updated with the new items.
    """

    return reduce(lambda acc, x: acc | {x: acc[x] + 1} if x in acc else acc | {x: 1}, items, inventory)


def decrement_items(inventory, items):
    """Decrement items in inventory using elements from the `items` list.

    :param inventory: dict - inventory dictionary.
    :param items: list - list of items to decrement from the inventory.
    :return: dict - updated inventory with items decremented.
    """

    return reduce(lambda acc, x: acc | {x: max(acc[x] - 1, 0)} if x in acc else acc, items, inventory)


def remove_item(inventory, item):
    """Remove item from inventory if it matches `item` string.

    :param inventory: dict - inventory dictionary.
    :param item: str - item to remove from the inventory.
    :return: dict - updated inventory with item removed. Current inventory if item does not match.
    """

    return reduce(lambda acc, x: acc if x == item else acc | {x: inventory[x]}, inventory, {})


def list_inventory(inventory):
    """Create a list containing all (item_name, item_count) pairs in inventory.

    :param inventory: dict - an inventory dictionary.
    :return: list of tuples - list of key, value pairs from the inventory dictionary.
    """

    return list(filter(lambda x: x[1] > 0, inventory.items()))