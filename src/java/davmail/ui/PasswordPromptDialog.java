/*
 * DavMail POP/IMAP/SMTP/CalDav/LDAP Exchange Gateway
 * Copyright (C) 2009  Mickael Guessant
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */
package davmail.ui;

import davmail.BundleMessage;
import davmail.ui.tray.DavGatewayTray;

import javax.swing.*;
import javax.swing.border.EmptyBorder;
import java.awt.*;

/**
 * Get smartcard password
 */
public class PasswordPromptDialog extends JDialog {
    final JPasswordField passwordField = new JPasswordField(20);
    protected char[] password;

    /**
     * Get user password.
     *
     * @return user password as char array
     */
    public char[] getPassword() {
        if (password != null) {
            return password.clone();
        } else {
            return "".toCharArray();
        }
    }

    /**
     * Get smartcard password.
     *
     * @param prompt password prompt from PKCS11 module
     */
    public PasswordPromptDialog(String prompt) {
        this(prompt, null);
    }

    /**
     * Get smartcard password.
     *
     * @param prompt       password prompt from PKCS11 module
     * @param captchaImage ISA filter pinsafe image
     */
    public PasswordPromptDialog(String prompt, Image captchaImage) {
        setAlwaysOnTop(true);

        setTitle(BundleMessage.format("UI_PASSWORD_PROMPT"));
        try {
            setIconImages(DavGatewayTray.getFrameIcons());
        } catch (NoSuchMethodError error) {
            DavGatewayTray.debug(new BundleMessage("LOG_UNABLE_TO_SET_ICON_IMAGE"));
        }


        JPanel questionPanel = new JPanel();
        questionPanel.setLayout(new BoxLayout(questionPanel, BoxLayout.Y_AXIS));
        JLabel imageLabel = new JLabel();
        imageLabel.setIcon(UIManager.getIcon("OptionPane.questionIcon"));
        imageLabel.setText(prompt);
        questionPanel.add(imageLabel);

        passwordField.addActionListener(e -> {
            password = passwordField.getPassword();
            setVisible(false);
        });

        JPanel passwordPanel = new JPanel();
        passwordPanel.setLayout(new BoxLayout(passwordPanel, BoxLayout.Y_AXIS));
        if (captchaImage != null) {
            JLabel captchaLabel = new JLabel(new ImageIcon(captchaImage));
            captchaLabel.setAlignmentX(Component.CENTER_ALIGNMENT);
            captchaLabel.setBorder(new EmptyBorder(10, 10, 10, 10));
            passwordPanel.add(captchaLabel);
        }
        passwordPanel.add(passwordField);

        add(questionPanel, BorderLayout.NORTH);
        add(passwordPanel, BorderLayout.CENTER);
        add(getButtonPanel(), BorderLayout.SOUTH);
        questionPanel.setBorder(BorderFactory.createEmptyBorder(5, 5, 0, 5));
        passwordPanel.setBorder(BorderFactory.createEmptyBorder(5, 5, 0, 5));
        setModal(true);

        pack();
        // center frame
        setLocation(getToolkit().getScreenSize().width / 2 -
                        getSize().width / 2,
                getToolkit().getScreenSize().height / 2 -
                        getSize().height / 2);
        setAlwaysOnTop(true);
        setVisible(true);
    }

    protected JPanel getButtonPanel() {
        JPanel buttonPanel = new JPanel();
        JButton okButton = new JButton(BundleMessage.format("UI_BUTTON_OK"));
        JButton cancelButton = new JButton(BundleMessage.format("UI_BUTTON_CANCEL"));
        okButton.addActionListener(evt -> {
            password = passwordField.getPassword();
            setVisible(false);
        });
        cancelButton.addActionListener(evt -> {
            password = null;
            setVisible(false);
        });

        buttonPanel.add(okButton);
        buttonPanel.add(cancelButton);
        return buttonPanel;
    }

}
