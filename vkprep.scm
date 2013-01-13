; GIMP - The GNU Image Manipulation Program
; Copyright (C) 1995 Spencer Kimball and Peter Mattis
;
; This program is free software; you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation; either version 2 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with this program; if not, write to the Free Software
; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
(define (script-fu-vkprep  image
                           drawable
                           autoLevels
                           sharpenAmount)

    (let*  (
            (img (car (gimp-image-duplicate image)))
            (drw (car (gimp-image-get-active-drawable img)))
            (owidth (car (gimp-image-width img)))
            (oheight (car (gimp-image-height img)))
            (scaleFactor (/ 1280 owidth))
            (newWidth  (round (* owidth scaleFactor))) 
            (newHeight (round (* oheight scaleFactor))) 
            )
 
        (gimp-context-push)
        (gimp-image-undo-disable img)
        
        (if (= autoLevels TRUE)
            (gimp-levels-auto drw)
        )
        (plug-in-unsharp-mask RUN-NONINTERACTIVE img drw 5 sharpenAmount 4)
        (gimp-image-scale img newWidth newHeight)

        (gimp-display-new img)
        (gimp-image-undo-enable img)
        (gimp-context-pop)
    ) 
)

(script-fu-register "script-fu-vkprep"
  _"_VKPrep..."
  _""
  "Tim Sattarov"
  "Tim Sattarov"
  "2012-10-10"
  "RGB* GRAY*"
  SF-IMAGE    _"Image"             0
  SF-DRAWABLE _"Drawable"          0
  SF-TOGGLE   _"Auto-levels"       TRUE
  SF-ADJUSTMENT _"Sharpen amount"  '(0.2 0 100 0.01 0.1 2 SF-SLIDER)
)

(script-fu-menu-register "script-fu-vkprep"
                         "<Image>/Filters/Render")
