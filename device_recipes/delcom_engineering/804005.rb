module Blinky
  module Vendor_0fc5
    module Product_1223
      
      class << self
          def vendor_name
              "Delcom Engineering"
          end

          def product_name
              "USB Visual Indicator- 804005"
          end

      end
      
      def show_success device_handle 
        green = 0xFF && ~0x01
        device_handle.usb_control_msg(0xc8, 0x12, 0x020a, green,"",0)  
      end
      
      def show_failure device_handle 
        red = 0xFF && ~0x02
        device_handle.usb_control_msg(0xc8, 0x12, 0x020a, red,"",0)  
      end
      
      def show_building device_handle 
        blue = 0xFF && ~0x04
        device_handle.usb_control_msg(0xc8, 0x12, 0x020a, blue,"",0)  
      end
      
      
    end
  end
end