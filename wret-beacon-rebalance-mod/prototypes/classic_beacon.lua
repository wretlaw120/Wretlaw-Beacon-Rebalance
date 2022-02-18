--the below is yoinked from Kirazy's Classic Beacon mod.

-- Copyright (c) 2020 Kirazy
-- Part of Classic Beacon
--
-- See LICENSE.md in the project directory for license information.

-- Technology icon
local beacon_technology = data.raw.technology["effect-transmission"]
beacon_technology.icon = "__wret-beacon-rebalance-mod__/classic_beacon_graphics/technology/effect-transmission.png"
beacon_technology.icon_size = 128
beacon_technology.icon_mipmaps = nil

-- Item icon
local beacon_item = data.raw["item"]["beacon"]
beacon_item.icon = "__wret-beacon-rebalance-mod__/classic_beacon_graphics/icon/beacon.png"
beacon_item.icon_size = 64
beacon_item.icon_mipmaps = 4

-- Entity icon
local beacon = data.raw["beacon"]["beacon"]
beacon.icon = "__wret-beacon-rebalance-mod__/classic_beacon_graphics/icon/beacon.png"
beacon.icon_size = 64
beacon.icon_mipmaps = 4

-- Restore old beacon sprites
beacon.corpse = "medium-remnants"
beacon.graphics_set = {
    module_icons_suppressed = false,

    animation_list = {
        -- Beacon Base
        {
            render_layer = "lower-object-above-shadow",
            always_draw = true,
            animation = {
                layers = {
                    -- Base
                    {
                        filename = "__wret-beacon-rebalance-mod__/classic_beacon_graphics/entity/beacon/beacon-base.png",
                        width = 116,
                        height = 93,
                        shift = util.by_pixel(11, 1.5),
                    },
                    -- Shadow
                    {
                        filename = "__wret-beacon-rebalance-mod__/classic_beacon_graphics/entity/beacon/beacon-base-shadow.png",
                        width = 116,
                        height = 93,
                        shift = util.by_pixel(11, 1.5),
                        draw_as_shadow = true,
                    }
                }
            }
        },
        -- Beacon Antenna
        {
            render_layer = "object",
            always_draw = true,
            animation = {
                layers = {
                    -- Base
                    {
                        filename = "__wret-beacon-rebalance-mod__/classic_beacon_graphics/entity/beacon/beacon-antenna.png",
                        width = 54,
                        height = 50,
                        line_length = 8,
                        frame_count = 32,
                        animation_speed = 0.5,
                        shift = util.by_pixel(-1, -55),
                    },
                    -- Shadow
                    {
                        filename = "__wret-beacon-rebalance-mod__/classic_beacon_graphics/entity/beacon/beacon-antenna-shadow.png",
                        width = 63,
                        height = 49,
                        line_length = 8,
                        frame_count = 32,
                        animation_speed = 0.5,
                        shift = util.by_pixel(100.5, 15.5),
                        draw_as_shadow = true,
                    }
                }
            }
        }
    }
}

if settings.startup["classic-beacon-do-high-res"].value == true then
    -- Beacon Base
    beacon.graphics_set.animation_list[1].animation.layers[1].hr_version = {
        filename = "__wret-beacon-rebalance-mod__/classic_beacon_graphics/entity/beacon/hr-beacon-base.png",
        width = 232,
        height = 186,
        shift = util.by_pixel(11, 1.5),
        scale = 0.5,
    }
    -- Beacon Base Shadow
    beacon.graphics_set.animation_list[1].animation.layers[2].hr_version = {
        filename = "__wret-beacon-rebalance-mod__/classic_beacon_graphics/entity/beacon/hr-beacon-base-shadow.png",
        width = 232,
        height = 186,
        shift = util.by_pixel(11, 1.5),
        draw_as_shadow = true,
        scale = 0.5,
    }
    -- Beacon Antenna Base
    beacon.graphics_set.animation_list[2].animation.layers[1].hr_version = {
        filename = "__wret-beacon-rebalance-mod__/classic_beacon_graphics/entity/beacon/hr-beacon-antenna.png",
        width = 108,
        height = 100,
        line_length = 8,
        frame_count = 32,
        animation_speed = 0.5,
        shift = util.by_pixel(-1, -55),
        scale = 0.5,
    }
    -- Beacon Antenna Shadow
    beacon.graphics_set.animation_list[2].animation.layers[2].hr_version = {
        filename = "__wret-beacon-rebalance-mod__/classic_beacon_graphics/entity/beacon/hr-beacon-antenna-shadow.png",
        width = 126,
        height = 98,
        line_length = 8,
        frame_count = 32,
        animation_speed = 0.5,
        shift = util.by_pixel(100.5, 15.5),
        draw_as_shadow = true,
        scale = 0.5,
    }
end

beacon.water_reflection = {
    pictures = {
        filename = "__wret-beacon-rebalance-mod__/classic_beacon_graphics/entity/beacon/beacon-reflection.png",
        priority = "extra-high",
        width = 24,
        height = 28,
        shift = util.by_pixel(0, 55),
        variation_count = 1,
        scale = 5,
    },
    rotate = false,
    orientation_to_variation = false
}

--below done by wretlaw120, copied from __base__, so that anything expecting module visualiztions (cough cough editor extensions) doesnt error

	beacon.graphics_set.module_visualisations = {
      -- vanilla art style
      {
        art_style = "vanilla",
        use_for_empty_slots = true,
        tier_offset = 0,
        slots =
        {
          -- slot 1
          {
            {
              has_empty_slot = true,
              render_layer = "lower-object",
              pictures =
              {
                filename = "__wret-beacon-rebalance-mod__/graphics/entity/beacon/blank.png",
                line_length = 4,
                width = 26,
                height = 34,
                variation_count = 4,
                shift = util.by_pixel(-16, 15),
                hr_version =
                {
                  filename = "__wret-beacon-rebalance-mod__/graphics/entity/beacon/blank.png",
                  line_length = 4,
                  width = 50,
                  height = 66,
                  variation_count = 4,
                  scale = 0.5,
                  shift = util.by_pixel(-16, 14.5)
                }
              }
            },
            {
              apply_module_tint = "primary",
              render_layer = "lower-object",
              pictures =
              {
                filename = "__wret-beacon-rebalance-mod__/graphics/entity/beacon/blank.png",
                line_length = 3,
                width = 18,
                height = 16,
                variation_count = 3,
                shift = util.by_pixel(-17, 15),
                hr_version =
                {
                  filename = "__wret-beacon-rebalance-mod__/graphics/entity/beacon/blank.png",
                  line_length = 3,
                  width = 36,
                  height = 32,
                  variation_count = 3,
                  scale = 0.5,
                  shift = util.by_pixel(-17, 15)
                }
              }
            },
            {
              apply_module_tint = "secondary",
              render_layer = "lower-object-above-shadow",
              pictures =
              {
                filename = "__wret-beacon-rebalance-mod__/graphics/entity/beacon/blank.png",
                line_length = 3,
                width = 14,
                height = 6,
                variation_count = 3,
                shift = util.by_pixel(-18, 13),
                hr_version =
                {
                  filename = "__wret-beacon-rebalance-mod__/graphics/entity/beacon/blank.png",
                  line_length = 3,
                  width = 26,
                  height = 12,
                  variation_count = 3,
                  scale = 0.5,
                  shift = util.by_pixel(-18.5, 13)
                }
              }
            },
            {
              apply_module_tint = "secondary",
              draw_as_light = true,
              draw_as_sprite = false,
              pictures =
              {
                filename = "__wret-beacon-rebalance-mod__/graphics/entity/beacon/blank.png",
                line_length = 3,
                width = 28,
                height = 22,
                variation_count = 3,
                shift = util.by_pixel(-18, 13),
                hr_version =
                {
                  filename = "__wret-beacon-rebalance-mod__/graphics/entity/beacon/blank.png",
                  line_length = 3,
                  width = 56,
                  height = 42,
                  variation_count = 3,
                  shift = util.by_pixel(-18, 13),
                  scale = 0.5
                }
              }
            }
          },
		  --slot 2 lazy copy version
		  {
            {
              has_empty_slot = true,
              render_layer = "lower-object",
              pictures =
              {
                filename = "__wret-beacon-rebalance-mod__/graphics/entity/beacon/blank.png",
                line_length = 4,
                width = 26,
                height = 34,
                variation_count = 4,
                shift = util.by_pixel(-16, 15),
                hr_version =
                {
                  filename = "__wret-beacon-rebalance-mod__/graphics/entity/beacon/blank.png",
                  line_length = 4,
                  width = 50,
                  height = 66,
                  variation_count = 4,
                  scale = 0.5,
                  shift = util.by_pixel(-16, 14.5)
                }
              }
            },
            {
              apply_module_tint = "primary",
              render_layer = "lower-object",
              pictures =
              {
                filename = "__wret-beacon-rebalance-mod__/graphics/entity/beacon/blank.png",
                line_length = 3,
                width = 18,
                height = 16,
                variation_count = 3,
                shift = util.by_pixel(-17, 15),
                hr_version =
                {
                  filename = "__wret-beacon-rebalance-mod__/graphics/entity/beacon/blank.png",
                  line_length = 3,
                  width = 36,
                  height = 32,
                  variation_count = 3,
                  scale = 0.5,
                  shift = util.by_pixel(-17, 15)
                }
              }
            },
            {
              apply_module_tint = "secondary",
              render_layer = "lower-object-above-shadow",
              pictures =
              {
                filename = "__wret-beacon-rebalance-mod__/graphics/entity/beacon/blank.png",
                line_length = 3,
                width = 14,
                height = 6,
                variation_count = 3,
                shift = util.by_pixel(-18, 13),
                hr_version =
                {
                  filename = "__wret-beacon-rebalance-mod__/graphics/entity/beacon/blank.png",
                  line_length = 3,
                  width = 26,
                  height = 12,
                  variation_count = 3,
                  scale = 0.5,
                  shift = util.by_pixel(-18.5, 13)
                }
              }
            },
            {
              apply_module_tint = "secondary",
              draw_as_light = true,
              draw_as_sprite = false,
              pictures =
              {
                filename = "__wret-beacon-rebalance-mod__/graphics/entity/beacon/blank.png",
                line_length = 3,
                width = 28,
                height = 22,
                variation_count = 3,
                shift = util.by_pixel(-18, 13),
                hr_version =
                {
                  filename = "__wret-beacon-rebalance-mod__/graphics/entity/beacon/blank.png",
                  line_length = 3,
                  width = 56,
                  height = 42,
                  variation_count = 3,
                  shift = util.by_pixel(-18, 13),
                  scale = 0.5
                }
              }
            }
          }
        }
      } -- end vanilla art style
    }